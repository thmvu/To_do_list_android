import 'package:flutter/material.dart';
import '../data/mock_tasks.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'create_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = mockTasks;

  void toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  // thêm task mới
  void addTask(String title) {
    setState(() {
      tasks.add(
        Task(
          id: DateTime.now().toString(),
          userId: "u1",
          title: title,
          image: "imgs/study.png",
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),

      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: tasks[index], onToggle: toggleTask);
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newTitle = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
          );

          if (newTitle != null) {
            addTask(newTitle);
          }
        },
      ),
    );
  }
}
