import 'team_member.dart';

enum Priority {
  low,
  medium,
  high,
}

class Task {
  String title;
  String description;
  Priority priority;
  TeamMember? assignee;
  bool done;

  Task({
    required this.title,
    required this.description,
    this.priority = Priority.medium,
    this.assignee,
    this.done = false,
  });
}