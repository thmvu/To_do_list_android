import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/color.dart';
import '../models/task.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  const CalendarScreen({super.key, required this.tasks});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Nhóm task theo ngày để dễ tra cứu, bỏ giờ/phút cho đồng nhất khi so sánh
  Map<DateTime, List<Task>> _groupTasksByDate() {
    final Map<DateTime, List<Task>> data = {};
    for (final task in widget.tasks) {
      final date = DateTime(
        task.createdAt.year,
        task.createdAt.month,
        task.createdAt.day,
      );
      data[date] = [...(data[date] ?? []), task];
    }
    return data;
  }

  List<Task> _getTasksForSelectedDay() {
    final key = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    return _groupTasksByDate()[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('task_calendar'.tr())),
      body: Column(
        children: [
          _buildCalendar(),
          const Divider(height: 1),
          _buildSelectedDayHeader(),
          Expanded(child: _buildTaskList()),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final taskMap = _groupTasksByDate();

    return TableCalendar<Task>(
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

      // Trả về task của ngày đó để table_calendar tự vẽ dấu chấm bên dưới
      eventLoader: (day) {
        final key = DateTime(day.year, day.month, day.day);
        return taskMap[key] ?? [];
      },

      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },

      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Custom_green.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Custom_green,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Custom_green,
          shape: BoxShape.circle,
        ),
      ),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSelectedDayHeader() {
    final formatted =
        '${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}';
    final tasks = _getTasksForSelectedDay();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 18, color: Custom_green),
          const SizedBox(width: 8),
          Text(
            formatted,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Custom_green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${tasks.length} task',
              style: TextStyle(
                fontSize: 13,
                color: Custom_green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    final tasks = _getTasksForSelectedDay();

    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'no_tasks'.tr(),
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) => _buildTaskTile(tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
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
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: task.completed ? Custom_green : Colors.grey,
      ),
    );
  }
}
