import 'package:flutter/material.dart';
import 'package:du_an_todolist/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage(user.avatar)),

            const SizedBox(height: 20),

            Text(
              user.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(user.email, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
