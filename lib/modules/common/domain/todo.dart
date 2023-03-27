class Todo {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.completed,
  });

  copyWith({
    String? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completed: completed ?? this.completed,
    );
  }
}
