import 'package:flutter/material.dart';
import '../data/mock_tasks.dart';
import '../models/task.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = mockTasks;

    return Scaffold(
      appBar: AppBar(title: const Text("Task Calendar")),

      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];

          return ListTile(
            leading: const Icon(Icons.calendar_today),

            title: Text(task.title),

            subtitle: Text(
              "${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}",
            ),
          );
        },
      ),
    );
  }
}
