import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/notification_service.dart';
import 'home/home_screen.dart';
import 'model/time_model.dart';

const String TIME_BOX = "links";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<TimeModel>(TimeModelAdapter());
  await Hive.openBox<TimeModel>(TIME_BOX);
  NotificationService().init();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DateTimePicker(),
    );
  }
}
