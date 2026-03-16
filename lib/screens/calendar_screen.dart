import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../data/mock_tasks.dart';
import '../models/task.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('task_calendar'.tr())),
      body: _buildTaskList(),
    );
  }


  Widget _buildTaskList() {
    final List<Task> tasks = mockTasks;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(task.title),
      subtitle: Text(
        "${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}",
      ),
    );
  }
}
