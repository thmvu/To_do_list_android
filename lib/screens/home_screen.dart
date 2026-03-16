import 'package:easy_localization/easy_localization.dart';
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
    currentUser = widget.user ??
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
    setState(() => task.completed = !task.completed);
  }

  int get completedCount => userTasks.where((t) => t.completed).length;

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date).inDays;
    if (diff == 0) return 'today'.tr();
    if (diff == 1) return 'yesterday'.tr();
    return 'days_ago'.tr(args: [diff.toString()]);
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('add_task'.tr()),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'enter_task'.tr()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              setState(() {
                userTasks.add(Task(
                  id: DateTime.now().toString(),
                  userId: currentUser.id,
                  title: controller.text.trim(),
                  createdAt: DateTime.now(),
                  image: "imgs/project.png",
                ));
              });
              Navigator.pop(ctx);
            },
            child: Text('add'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildTasksTab(),
          CalendarScreen(tasks: userTasks),
          ProfileScreen(user: currentUser, taskCount: userTasks.length),
          const AboutScreen(),
        ],
      ),
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
            'hello'.tr(args: [currentUser.name]),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        _buildLangButton('VI', const Locale('vi')),
        _buildLangButton('EN', const Locale('en')),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Login_Screen()),
          ),
        ),
      ],
    );
  }

  Widget? _buildFAB() {
    if (_currentIndex != 0) return null;
    return FloatingActionButton(
      backgroundColor: Custom_green,
      onPressed: _showAddTaskDialog,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildLangButton(String label, Locale locale) {
    final isActive = context.locale == locale;
    return GestureDetector(
      onTap: () => context.setLocale(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? Custom_green : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      selectedItemColor: Custom_green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.checklist_rounded),
          label: 'nav_tasks'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today),
          label: 'nav_calendar'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'nav_profile'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info_outline),
          label: 'nav_about'.tr(),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        _buildProgressHeader(),
        Expanded(
          child: userTasks.isEmpty
              ? _buildEmptyState()
              : _buildTaskList(),
        ),
      ],
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      width: double.infinity,
      color: Custom_green,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'tasks_completed'.tr(args: [
              completedCount.toString(),
              userTasks.length.toString(),
            ]),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: userTasks.isEmpty ? 0 : completedCount / userTasks.length,
              backgroundColor: Colors.white38,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'no_tasks'.tr(),
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: userTasks.length,
      itemBuilder: (context, index) => _buildTaskCard(userTasks[index]),
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
            task.completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: task.completed ? Custom_green : Colors.grey,
          ),
        ),
      ),
    );
  }
}