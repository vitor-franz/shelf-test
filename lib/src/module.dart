import 'package:shelf_router/shelf_router.dart';

/// A feature's routes, such as tasks, mounted by `buildRouter`.
///
/// Each feature implements this and exposes its endpoints under [prefix]. To
/// add a feature, implement it in the feature's `module.dart` and pass an
/// instance to `buildRouter`.
abstract interface class Module {
  /// Path the module's routes are mounted under, such as `/tasks`.
  ///
  /// Must start with `/` and must not end with `/`.
  String get prefix;

  /// The module's routes, relative to [prefix].
  Router get router;
}
