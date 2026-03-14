import 'package:flutter/material.dart';
import 'package:du_an_todolist/const/color.dart';
import 'package:du_an_todolist/data/mock_tasks.dart';
import 'package:du_an_todolist/models/task.dart';
import 'package:du_an_todolist/models/user.dart';

import 'package:du_an_todolist/screens/login_screen.dart';
import 'package:du_an_todolist/screens/about_screen.dart';
import 'package:du_an_todolist/screens/calendar_screen.dart';
import 'package:du_an_todolist/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late User currentUser;
  late List<Task> userTasks;

  @override
  void initState() {
    super.initState();

    currentUser =
        widget.user ??
        User(
          id: "u1",
          name: "Guest",
          email: "guest@email.com",
          password: "",
          avatar: "imgs/avatar.png",
        );

    userTasks = mockTasks.where((t) => t.userId == currentUser.id).toList();
  }

  void _toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  int get completedCount => userTasks.where((t) => t.completed).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Custom_green,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(currentUser.avatar),
            ),
            const SizedBox(width: 10),
            Text(
              "Xin chào, ${currentUser.name}!",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Login_Screen()),
              );
            },
          ),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildTasksTab(),
          const CalendarScreen(),
          ProfileScreen(user: currentUser),
          const AboutScreen(),
        ],
      ),

      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: Custom_green,
              onPressed: _showAddTaskDialog,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Custom_green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: "Nhiệm vụ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Lịch",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Hồ sơ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "Giới thiệu",
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Custom_green,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$completedCount / ${userTasks.length} nhiệm vụ hoàn thành",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: userTasks.isEmpty
                      ? 0
                      : completedCount / userTasks.length,
                  backgroundColor: Colors.white38,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: userTasks.isEmpty
              ? const Center(
                  child: Text(
                    "Chưa có nhiệm vụ nào!",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: userTasks.length,
                  itemBuilder: (context, index) {
                    return _buildTaskCard(userTasks[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            task.image,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
            color: task.completed ? Colors.grey : Colors.black87,
          ),
        ),

        subtitle: Text(_formatDate(task.createdAt)),

        trailing: GestureDetector(
          onTap: () => _toggleTask(task),
          child: Icon(
            task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: task.completed ? Custom_green : Colors.grey,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;

    if (diff == 0) return "Hôm nay";
    if (diff == 1) return "Hôm qua";

    return "$diff ngày trước";
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Thêm nhiệm vụ"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Nhập nhiệm vụ..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Huỷ"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;

              setState(() {
                userTasks.add(
                  Task(
                    id: DateTime.now().toString(),
                    userId: currentUser.id,
                    title: controller.text.trim(),
                    createdAt: DateTime.now(),
                    image: "imgs/task.png",
                  ),
                );
              });

              Navigator.pop(ctx);
            },
            child: const Text("Thêm"),
          ),
        ],
      ),
    );
  }
}