import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../module.dart';
import 'entity.dart';
import 'use_case.dart';

/// Creates the tasks [Module], which serves tasks through the given [useCase]
/// under `/tasks`.
Module newTaskModule(TaskUseCase useCase) {
  return _TaskModule(useCase);
}

class _TaskModule implements Module {
  _TaskModule(this._useCase);

  final TaskUseCase _useCase;

  @override
  String get prefix {
    return '/tasks';
  }

  @override
  Router get router {
    final router = Router();

    router.get('/', _listAllTasks);
    router.post('/', _createTask);
    router.get('/<id|[0-9]+>', _getTaskByID);
    router.put('/<id|[0-9]+>', _updateTask);
    router.delete('/<id|[0-9]+>', _deleteTask);

    return router;
  }

  Response _listAllTasks(Request request) {
    final tasks = _useCase.listAllTasks().map((task) {
      return task.toJSON();
    }).toList();

    return Response(
      200,
      body: jsonEncode(tasks),
      headers: {'content-type': 'application/json'},
    );
  }

  Future<Response> _createTask(Request request) async {
    final body = jsonDecode(await request.readAsString());
    final task = Task.fromJSON(body as Map<String, dynamic>);
    _useCase.createTask(task);

    return Response(201);
  }

  Response _getTaskByID(Request request, String id) {
    final task = _useCase.getTaskByID(int.parse(id));
    if (task == null) {
      return Response(404);
    }

    return Response(
      200,
      body: jsonEncode(task.toJSON()),
      headers: {'content-type': 'application/json'},
    );
  }

  Future<Response> _updateTask(Request request, String id) async {
    final body = jsonDecode(await request.readAsString());
    final task = Task.fromJSON(body as Map<String, dynamic>)
        .copyWith(id: int.parse(id));

    if (!_useCase.updateTask(task)) {
      return Response(404);
    }

    return Response(204);
  }

  Response _deleteTask(Request request, String id) {
    if (!_useCase.deleteTask(int.parse(id))) {
      return Response(404);
    }

    return Response(204);
  }
}
