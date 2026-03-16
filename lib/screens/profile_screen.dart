import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:du_an_todolist/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final int taskCount;
  const ProfileScreen({super.key, required this.user, this.taskCount = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAvatar(),
            const SizedBox(height: 20),
            _buildName(),
            const SizedBox(height: 10),
            _buildEmail(),
            const SizedBox(height: 10),
            _buildTasksCount(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(radius: 50, backgroundImage: AssetImage(user.avatar));
  }

  Widget _buildName() {
    return Text(
      user.name,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEmail() {
    return Text(user.email, style: const TextStyle(fontSize: 16));
  }

  Widget _buildTasksCount() {
    return Text(
      'tasks_count'.tr(args: [taskCount.toString()]),
      style: const TextStyle(fontSize: 16, color: Colors.grey),
    );
  }
}
