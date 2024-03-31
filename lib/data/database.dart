import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Database {
  final box = Hive.box('box');

  static List<Appointment> todo = [];
  List<dynamic> dynamicList = [];
  void loadDatabase() {
    dynamicList = box.get('todo');
  }

  void updateDatabase() {
    box.put('todo', todo);
  }
}
