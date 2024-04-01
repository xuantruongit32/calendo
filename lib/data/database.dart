import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentAdapter extends TypeAdapter {
  @override
  final int typeId = 0;

  @override
  Appointment read(BinaryReader reader) {
    final title = reader.readString();
    final startTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final endTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final color = reader.readInt();
    return Appointment(
      subject: title,
      startTime: startTime,
      endTime: endTime,
      color: Color(color),
    );
  }

  @override
  void write(BinaryWriter writer, dynamic obj) {
    if (obj is Appointment) {
      writer.writeString(obj.subject);
      writer.writeInt(obj.startTime.millisecondsSinceEpoch);
      writer.writeInt(obj.endTime.millisecondsSinceEpoch);
      writer.writeInt(obj.color.value);
    } else {
      throw ArgumentError('Not appointment');
    }
  }
}

class Database {
  final box = Hive.box('box');

  static List<Appointment> todo = [];
  static List<dynamic> dynamicList = [];
  void loadDatabase() {
    dynamicList = box.get('todo');
  }

  void updateDatabase() {
    box.put('todo', todo);
  }
}
