import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About This App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "App này là một ứng dụng để giúp người dùng quản lý công việc của mình. Nó cung cấp các tính năng như tạo, chỉnh sửa và xóa công việc, cũng như theo dõi tiến độ của chúng.",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Team phát triển:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            buildTeamMember(
              "Từ Hữu Minh Vũ",
              "Project Manager",
              "Đảm bảo tiến độ và chất lượng của dự án.",
              Icons.code,
            ),
            const SizedBox(height: 10),
            buildTeamMember(
              "Phạm Thị Minh Ngọc",
              "Thành Viên",
              "Phát triển các tính năng cùng với bạn trưởng",
              Icons.developer_mode,
            ),

            const Spacer(),

            const Center(
              child: Text(
                "© 2026 Todo list cua toi",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTeamMember(
  String name,
  String role,
  String description,
  IconData icon,
) {
  return Row(
    children: [
      CircleAvatar(radius: 30, child: Icon(icon, size: 30)),
      const SizedBox(width: 15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(role, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(description, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ],
  );
}
