import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/task.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  double completionFor(Priority priority) {
    final priorityTasks = tasks
        .where((task) => task.priority == priority)
        .toList();

    if (priorityTasks.isEmpty) {
      return 0;
    }

    final completed = priorityTasks
        .where((task) => task.done)
        .length;

    return completed / priorityTasks.length;
  }

  int countByPriority(Priority priority) {
    return tasks
        .where((task) => task.priority == priority)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final total = tasks.length;

    final done = tasks
        .where((task) => task.done)
        .length;

    final pending = tasks
        .where((task) => !task.done)
        .length;

    final highPriority = tasks
        .where((task) => task.priority == Priority.high)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _StatCard(
                  title: 'Total',
                  value: total.toString(),
                  icon: Icons.task,
                ),
                _StatCard(
                  title: 'Done',
                  value: done.toString(),
                  icon: Icons.check_circle,
                ),
                _StatCard(
                  title: 'Pending',
                  value: pending.toString(),
                  icon: Icons.pending_actions,
                ),
                _StatCard(
                  title: 'High Priority',
                  value: highPriority.toString(),
                  icon: Icons.priority_high,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Completion by Priority',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _PriorityProgress(
              priority: Priority.high,
              count: countByPriority(Priority.high),
              progress: completionFor(Priority.high),
            ),

            _PriorityProgress(
              priority: Priority.medium,
              count: countByPriority(Priority.medium),
              progress: completionFor(Priority.medium),
            ),

            _PriorityProgress(
              priority: Priority.low,
              count: countByPriority(Priority.low),
              progress: completionFor(Priority.low),
            ),

            const SizedBox(height: 20),

            if (total > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall Completion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: done / total,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${((done / total) * 100).toStringAsFixed(0)}% completed',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _PriorityProgress extends StatelessWidget {
  final Priority priority;
  final int count;
  final double progress;

  const _PriorityProgress({
    required this.priority,
    required this.count,
    required this.progress,
  });

  Color get color {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 75,
                child: Text(
                  priority.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text('$count tasks'),
              const Spacer(),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
              ),
            ],
          ),

          const SizedBox(height: 8),

          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
        ],
      ),
    );
  }
}