/// A unit of work that can be marked as done.
class Task {
  /// Default constructor.
  const Task({this.id, required this.title, this.done = false});

  /// Creates a task from a JSON map such as `{"title": String, "done": bool?}`.
  ///
  /// `id` is optional and `done` defaults to false.
  factory Task.fromJSON(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int?,
      title: json['title'] as String,
      done: json['done'] as bool? ?? false,
    );
  }

  /// Unique identifier assigned by the repository, or null if not stored yet.
  final int? id;

  /// Short description of the task. Never empty.
  final String title;

  /// Whether the task has been completed.
  final bool done;

  /// Returns a copy of this task with the given fields replaced.
  Task copyWith({int? id, String? title, bool? done}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }

  /// Converts this task to a JSON-encodable map.
  Map<String, dynamic> toJSON() {
    return {'id': id, 'title': title, 'done': done};
  }
}
