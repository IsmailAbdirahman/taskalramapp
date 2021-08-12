import 'dart:math';
import 'package:alaramtaskapp/model/time_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen_state.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  double? _height;
  double? _width;

  String? _hour, _minute, _time;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn]).toString();
        int id = Random().nextInt(1000);
        context.read(homeProvider).saveTime(id, _timeController.text);
        notifyBeforeDeleting(id, _timeController.text);
      });
  }

  notifyBeforeDeleting(int id, String item) async {
    String timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'key2',
          title: "Alarm is triggered",
        ),
        schedule: NotificationCalendar(
          allowWhileIdle: true,
          repeats: false,
          hour: int.parse(item.split(":")[0]),
          minute: int.parse(item.split(":")[1]),
          second: 0,
          timeZone: timeZone,
        ));
  }

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Alarm'),
      ),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Text(
                'Choose Time',
                style:
                TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: _width! / 1.7,
                  height: _height! / 9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Container(
              padding: const EdgeInsets.only(left: 18, top: 10),
              alignment: Alignment.topLeft,
              child: Text("Time for Notifications")),
          Consumer(
            builder: (BuildContext context, watch, child) {
              final alarmTimes = watch(homeProvider);
              List<TimeModel> data = alarmTimes.getTimes();

              return Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onLongPress: () {
                          alarmTimes.deleteTime(data[index].id!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            data[index].time!,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
