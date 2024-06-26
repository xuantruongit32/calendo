import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.addNewTodo});
  final Function(Appointment appointment) addNewTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  Color todoColor = Colors.blue;
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

  void _changeColorTodo(dynamic color) {
    setState(() {
      todoColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: _changeColorTodo,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                height: 16,
                child: Container(
                  color: Colors.blue,
                  height: 16,
                ),
              ),
              PopupMenuItem(
                value: Colors.brown,
                height: 16,
                child: Container(
                  color: Colors.brown,
                  height: 16,
                ),
              ),
              PopupMenuItem(
                value: Colors.orange,
                height: 16,
                child: Container(
                  color: Colors.orange,
                  height: 16,
                ),
              ),
              PopupMenuItem(
                value: Colors.amber,
                height: 16,
                child: Container(
                  color: Colors.amber,
                  height: 16,
                ),
              ),
              PopupMenuItem(
                value: Colors.purple,
                height: 16,
                child: Container(
                  color: Colors.purple,
                  height: 16,
                ),
              ),
              PopupMenuItem(
                value: Colors.yellow,
                height: 16,
                child: Container(
                  color: Colors.yellow,
                  height: 16,
                ),
              ),
            ],
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: todoColor,
              ),
              width: 24,
              height: 24,
            ),
          ),
          TextButton(
            onPressed: () {
              Appointment appointment = Appointment(
                  startTime: selectedTimeBegin,
                  endTime: selectedTimeEnd,
                  subject: _titleController.text,
                  color: todoColor);
              widget.addNewTodo(appointment);
            },
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
