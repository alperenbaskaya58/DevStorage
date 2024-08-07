import 'dart:developer';
import 'package:dev_storage_package/dev_storage_package.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class NotificationW {
  String TOPIC_NAME ;
  String fcmTokenKey;
  NotificationW(this.TOPIC_NAME, this.fcmTokenKey);
  
  initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? fcm_token = await messaging.getToken();
    log("token there $fcm_token");
    DevStorage devStorage = DevStorage();
    devStorage.setKeysValue(fcmTokenKey, fcm_token);

    await messaging.subscribeToTopic(TOPIC_NAME);

  }
}

class NotifController extends GetxController {
  Function(RemoteMessage message) onBackgroundMessageX ;
  Function(RemoteMessage message) getInitialMessageX ;
  Function(RemoteMessage message) onMessageX ;
  Function(RemoteMessage message) onMessageOpenedAppX ;




  NotifController (this.onBackgroundMessageX,
                   this.getInitialMessageX,
                   this.onMessageX,
                   this.onMessageOpenedAppX

                  );


  @override
  Future<void> onInit() async {

  FirebaseMessaging.onBackgroundMessage((message) async {
    if (message != null) {
        await showNotification(message);
        onBackgroundMessageX(message);
      }
  });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      log("notif $message");

      if (message != null) {
        await showNotification(message);
        getInitialMessageX(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("notif $message");
      if (message != null) {
        await showNotification(message);
        onMessageX(message);
        
              }
    });

    // eger mesaj url iceriyorsa o sayfaya yonlendirme
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message != null) {
        await showNotification(message);
        onMessageOpenedAppX(message);
        
    
      }

      log("notif $message");
    });
    super.onInit();
  }


   showNotification( RemoteMessage message) async {
        FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var androidw = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSw = DarwinInitializationSettings();
    var initSetttings = InitializationSettings(android: androidw, iOS: iOSw);
    flp.initialize(initSetttings);
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.max
  );
  var android = AndroidNotificationDetails('channel id', 'channel NAME',
      channelDescription: 'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max);
  var iOS = DarwinNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(DateTime.now().microsecond, message.notification!.title, message.notification!.body, platform );
}


}