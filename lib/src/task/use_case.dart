import 'entity.dart';
import 'repository.dart';

/// Business rules for managing tasks.
abstract class TaskUseCase {
  /// Returns every task.
  List<Task> listAllTasks();

  /// Returns the task with the given [id], or null if it does not exist.
  Task? getTaskByID(int id);

  /// Creates [task] under a newly generated id. The id of [task] is ignored.
  void createTask(Task task);

  /// Replaces the task that has the same id as [task].
  ///
  /// Returns false if no task with that id exists.
  bool updateTask(Task task);

  /// Deletes the task with the given [id].
  ///
  /// Returns false if it does not exist.
  bool deleteTask(int id);
}

/// Creates a [TaskUseCase] that stores tasks in the given [repository].
TaskUseCase newTaskUseCase(TaskRepository repository) {
  return _TaskUseCase(repository);
}

class _TaskUseCase implements TaskUseCase {
  _TaskUseCase(this._repository);

  final TaskRepository _repository;

  @override
  List<Task> listAllTasks() {
    return _repository.listAllTasks();
  }

  @override
  Task? getTaskByID(int id) {
    return _repository.getTaskByID(id);
  }

  @override
  void createTask(Task task) {
    _repository.createTask(task);
  }

  @override
  bool updateTask(Task task) {
    final existing = _repository.getTaskByID(task.id!);
    if (existing == null) {
      return false;
    }

    _repository.updateTask(task);
    return true;
  }

  @override
  bool deleteTask(int id) {
    final task = _repository.getTaskByID(id);
    if (task == null) {
      return false;
    }

    _repository.deleteTask(id);
    return true;
  }
}
