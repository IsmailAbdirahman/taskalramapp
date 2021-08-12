import 'package:alaramtaskapp/model/time_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

class Database {
  saveTime(int id, String time) {
    Box<TimeModel> timeStorage = Hive.box<TimeModel>(TIME_BOX);
    print("THE SAVED ID IS ::: $id");
    timeStorage.put(id, TimeModel(id:id,time: time));
  }

  List<TimeModel> getTimes() {
    List<TimeModel> timeList = Hive.box<TimeModel>(TIME_BOX).values.toList();
    return timeList;
  }

  deleteTime(int id) {
    Box<TimeModel> timeStorage = Hive.box<TimeModel>(TIME_BOX);
    timeStorage.delete(id);
  }
}
