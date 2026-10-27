import 'entity.dart';

/// Storage for [Task]s.
abstract class TaskRepository {
  /// Returns every stored task.
  List<Task> listAllTasks();

  /// Returns the task with the given [id], or null if it does not exist.
  Task? getTaskByID(int id);

  /// Stores [task] under a newly generated id. The id of [task] is ignored.
  void createTask(Task task);

  /// Replaces the stored task that has the same id as [task].
  /// Does nothing if no task with that id exists.
  void updateTask(Task task);

  /// Removes the task with the given [id].
  /// Does nothing if it does not exist.
  void deleteTask(int id);
}

/// Creates a [TaskRepository] that keeps tasks in memory.
/// Tasks are lost when the process exits. Ids start at 1 and are never reused.
TaskRepository newTaskRepository() {
  return _TaskRepository();
}

class _TaskRepository implements TaskRepository {
  _TaskRepository();

  final _tasks = <int, Task>{};
  var _nextId = 1;

  @override
  List<Task> listAllTasks() {
    return _tasks.values.toList();
  }

  @override
  Task? getTaskByID(int id) {
    return _tasks[id];
  }

  @override
  void createTask(Task task) {
    final id = _nextId++;
    _tasks[id] = task.copyWith(id: id);
  }

  @override
  void updateTask(Task task) {
    if (!_tasks.containsKey(task.id)) {
      return;
    }

    _tasks[task.id!] = task;
  }

  @override
  void deleteTask(int id) {
    _tasks.remove(id);
  }
}
