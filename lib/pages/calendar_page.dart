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

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
    dynamic appointment = appointmentDragEndDetails.appointment!;
    DateTime? droppingTime = appointmentDragEndDetails.droppingTime;

    if (droppingTime != null && appointment != null) {
      Duration appointmentDuration = appointment.endTime.difference(appointment.startTime);
      DateTime newStartTime = droppingTime;
      DateTime newEndTime = newStartTime.add(appointmentDuration);

      for (int i = 0; i < Database.todo.length; i++) {
        if (Database.todo[i].id == appointment.id) {
          Database.todo[i].startTime = newStartTime;
          Database.todo[i].endTime = newEndTime;
          Database().updateDatabase();
          break;
        }
      }
    }
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
        allowAppointmentResize: true,
        onDragEnd: dragEnd,
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
