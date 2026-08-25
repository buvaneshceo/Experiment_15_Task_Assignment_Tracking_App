import '../models/task.dart';
import '../models/team_member.dart';

final List<TeamMember> team = [
  TeamMember(
    name: 'Ananya R.',
    role: 'UI Designer',
  ),
  TeamMember(
    name: 'Rahul Dev',
    role: 'Frontend Dev',
  ),
  TeamMember(
    name: 'Sneha Pillai',
    role: 'QA Engineer',
  ),
];

final List<Task> tasks = [
  Task(
    title: 'Fix API timeout',
    description: 'Investigate slow endpoint',
    priority: Priority.high,
  ),
  Task(
    title: 'Update docs',
    description: 'Refresh README',
    priority: Priority.medium,
    done: true,
  ),
  Task(
    title: 'Team standup notes',
    description: 'Share summary',
    priority: Priority.low,
    done: true,
  ),
];