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
  @override
  void initState() {
    Database().loadDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTodo(),
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
  if (Database().dynamicList.isEmpty) {
    Database.todo.add(
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(
          Duration(hours: 2),
        ),
        color: Colors.blue,
        subject: 'Test1',
      ),
    );
    return Database.todo;
  } else {
    for (var item in Database().dynamicList) {
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
