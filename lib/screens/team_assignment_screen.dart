import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/task.dart';

class TeamAssignmentScreen extends StatefulWidget {
  final Task task;

  const TeamAssignmentScreen({
    super.key,
    required this.task,
  });

  @override
  State<TeamAssignmentScreen> createState() =>
      _TeamAssignmentScreenState();
}

class _TeamAssignmentScreenState
    extends State<TeamAssignmentScreen> {

  void assignMember(int index) {
    setState(() {
      widget.task.assignee = team[index];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${team[index].name} assigned successfully',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: team.length,
        itemBuilder: (context, index) {
          final member = team[index];
          final selected =
              widget.task.assignee == member;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: CircleAvatar(
                radius: 25,
                child: Text(
                  member.name[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(member.role),
              ),

              trailing: ElevatedButton(
                onPressed: () => assignMember(index),
                child: Text(
                  selected ? 'Assigned' : 'Assign',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}