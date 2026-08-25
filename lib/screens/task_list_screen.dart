import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/task.dart';
import 'dashboard_screen.dart';
import 'task_creation_screen.dart';
import 'team_assignment_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Color priorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  String priorityText(Priority priority) {
    return priority.name.toUpperCase();
  }

  Future<void> openCreateTask() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TaskCreationScreen(),
      ),
    );

    setState(() {});
  }

  Future<void> openAssignment(Task task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TeamAssignmentScreen(task: task),
      ),
    );

    setState(() {});
  }

  Future<void> openDashboard() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.done).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks (${tasks.length})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Dashboard',
            icon: const Icon(Icons.bar_chart),
            onPressed: openDashboard,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openCreateTask,
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          title: 'Total',
                          value: tasks.length.toString(),
                          icon: Icons.task_alt,
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          title: 'Completed',
                          value: completedTasks.toString(),
                          icon: Icons.check_circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final color = priorityColor(task.priority);

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.done,
                              onChanged: (value) {
                                setState(() {
                                  task.done = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: task.done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(task.description),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          task.assignee?.name ??
                                              'Unassigned',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: Chip(
                              label: Text(
                                priorityText(task.priority),
                              ),
                              backgroundColor:
                                  color.withOpacity(0.15),
                              labelStyle: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => openAssignment(task),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: Icon(
            icon,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}