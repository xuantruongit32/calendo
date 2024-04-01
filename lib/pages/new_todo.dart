import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  DateTime selectedTimeBegin = DateTime.now();
  DateTime selectedTimeEnd = DateTime.now().add(
    const Duration(hours: 1),
  );
  final _titleController = TextEditingController();
  Future<void> _selectDate(bool beginOrEnd) async {
    var pick = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (pick != null) {
      setState(() {
        beginOrEnd ? selectedTimeBegin = pick : selectedTimeEnd = pick;
      });
    }
  }

  Future<void> _selectTime(bool beginOrEnd) async {
    var pick = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(beginOrEnd ? selectedTimeBegin : selectedTimeEnd));
    if (pick != null) {
      setState(() {
        beginOrEnd
            ? selectedTimeBegin =
                DateTime(selectedTimeBegin.year, selectedTimeBegin.month, selectedTimeBegin.day, pick.hour, pick.minute)
            : selectedTimeEnd =
                DateTime(selectedTimeEnd.year, selectedTimeEnd.month, selectedTimeEnd.day, pick.hour, pick.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Add Title',
                hintStyle: TextStyle(
                  fontSize: 36,
                ),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 36,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDate(true);
                  },
                  child: Text(
                    DateFormat('E, MMM dd, yyyy').format(selectedTimeBegin),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    _selectTime(true);
                  },
                  child: Text(
                    DateFormat.jm().format(selectedTimeBegin),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDate(false);
                  },
                  child: Text(
                    DateFormat('E, MMM dd, yyyy').format(selectedTimeEnd),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: () {
                    _selectTime(false);
                  },
                  child: Text(
                    DateFormat.jm().format(selectedTimeEnd),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
