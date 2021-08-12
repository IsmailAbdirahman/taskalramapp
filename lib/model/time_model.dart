import 'package:hive/hive.dart';

part 'time_model.g.dart';

@HiveType(typeId: 0)
class TimeModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? time;

  TimeModel({this.id, this.time});
}
