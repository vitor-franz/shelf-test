import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_example/shelf_example.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Repositories.
  final taskRepository = newTaskRepository();

  // Use cases.
  final taskUseCase = newTaskUseCase(taskRepository);

  // Modules.
  final taskModule = newTaskModule(taskUseCase);

  // Register the feature modules served by the API.
  final router = buildRouter(modules: [taskModule]);

  // Configure a pipeline that logs requests. Pipeline is immutable, so each
  // call returns a new one that must be kept.
  var pipeline = Pipeline();
  pipeline = pipeline.addMiddleware(logRequests());

  final handler = pipeline.addHandler(router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
