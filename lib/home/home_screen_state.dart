import 'package:alaramtaskapp/local_storage/database.dart';
import 'package:alaramtaskapp/model/time_model.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeState());

class HomeState extends ChangeNotifier {
  Database _database = Database();

  saveTime(int id, String time) {
    _database.saveTime(id, time);
    notifyListeners();
  }

  List<TimeModel> getTimes() {
    return _database.getTimes();
  }

  deleteTime(int id) {
    _database.deleteTime(id);
    AwesomeNotifications().cancel(id);
    notifyListeners();
  }
}
