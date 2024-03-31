import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedTimeBegin = DateTime.now();
    DateTime _selectedTimeEnd = DateTime.now().add(
      const Duration(hours: 1),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Add Title',
                hintStyle: TextStyle(
                  fontSize: 36,
                ),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  DateFormat('E, MMM dd, yyyy').format(_selectedTimeBegin),
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 50),
                Text(
                  DateFormat.jm().format(_selectedTimeBegin),
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  DateFormat('E, MMM dd, yyyy').format(_selectedTimeEnd),
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  DateFormat.jm().format(_selectedTimeEnd),
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
