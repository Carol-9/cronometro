import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(initSettings);
  }

  static Future<void> showPersistentRunningNotification(String time) async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
    );

    await _notifications.show(
      1,
      'Cronômetro em andamento',
      'Tempo atual: $time',
      const NotificationDetails(android: androidDetails),
    );
  }

  static Future<void> showLapNotification(String lapTime, String totalTime) async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, 
      'Volta registrada',
      'Volta: $lapTime | Total: $totalTime',
      const NotificationDetails(android: androidDetails),
    );
  }

  static Future<void> showResumeSuggestion() async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    await _notifications.show(
      2, 
      'Cronômetro pausado',
      'Você deseja retomar a contagem?',
      const NotificationDetails(android: androidDetails),
    );
  }

  static Future<void> cancelPersistentNotification() async {
    await _notifications.cancel(1);
  }
}
