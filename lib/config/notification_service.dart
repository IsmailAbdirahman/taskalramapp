import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  init() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'key2',
            channelName: 'Notification about posts',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        print("NOT ALLOWED");
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
}
