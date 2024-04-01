import 'package:calendo/data/database.dart';
import 'package:calendo/pages/new_todo.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  void _addNewTodo(Appointment appointment) {
    setState(() {
      Database.todo.add(appointment);
    });
    Database().updateDatabase();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTodo(
                addNewTodo: _addNewTodo,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 2,
        showDatePickerButton: true,
        showTodayButton: true,
        showNavigationArrow: true,
        showCurrentTimeIndicator: true,
        allowDragAndDrop: true,
        dataSource: MeetingDataSource(getTodo()),
      ),
    );
  }
}

List<Appointment> getTodo() {
  if (Database.dynamicList.isEmpty) {
    return Database.todo;
  } else {
    for (var item in Database.dynamicList) {
      if (item is Appointment) {
        Database.todo.add(item);
      }
    }
    return Database.todo;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
