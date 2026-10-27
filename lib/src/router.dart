import 'package:shelf_router/shelf_router.dart';

import 'module.dart';

/// Builds the application's root [Router].
/// Mounts each of the [modules] under its [Module.prefix].
Router buildRouter({List<Module> modules = const []}) {
  final router = Router();

  for (final module in modules) {
    router.mount(module.prefix, module.router.call);
  }

  return router;
}
