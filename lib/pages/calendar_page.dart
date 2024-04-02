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
  Appointment? _selectedAppointment;
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

  void resizeEnd(AppointmentResizeEndDetails appointmentResizeEndDetails) {
    dynamic appointment = appointmentResizeEndDetails.appointment;
    DateTime? startTime = appointmentResizeEndDetails.startTime;
    DateTime? endTime = appointmentResizeEndDetails.endTime;
    if (appointment != null) {
      for (var i = 0; i < Database.todo.length; i++) {
        if (appointment.id == Database.todo[i].id) {
          Database.todo[i].startTime = startTime!;
          Database.todo[i].endTime = endTime!;
          Database().updateDatabase();
          break;
        }
      }
    }
  }

  void calendarTapped(CalendarLongPressDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];
      _selectedAppointment = appointment;
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
        onAppointmentResizeEnd: resizeEnd,
        onLongPress: (CalendarLongPressDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            calendarTapped(details);
            print(_selectedAppointment!.subject);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Appointment'),
                content: const Text('Are you sure you want to delete this appointment?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_selectedAppointment != null) {
                        setState(() {
                          Database.todo.removeAt(Database.todo.indexOf(_selectedAppointment!));
                          getTodo().notifyListeners(CalendarDataSourceAction.remove, []..add(_selectedAppointment!));
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          }
        },
        dataSource: getTodo(),
      ),
    );
  }
}

MeetingDataSource getTodo() {
  if (Database.dynamicList.isEmpty) {
    return MeetingDataSource(Database.todo);
  } else {
    for (var item in Database.dynamicList) {
      if (item is Appointment) {
        Database.todo.add(item);
      }
    }
    return MeetingDataSource(Database.todo);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
