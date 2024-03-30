import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 2,
        showDatePickerButton: true,
        showTodayButton: true,
        showNavigationArrow: true,
        showCurrentTimeIndicator: true,
        allowDragAndDrop: true,
      ),
    );
  }
}
