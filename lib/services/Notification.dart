import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// Inicializa o serviço de notificações
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(initSettings);
  }

  /// Notificação persistente quando o cronômetro está rodando
  static Future<void> showPersistentRunningNotification(String time) async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
      styleInformation: BigTextStyleInformation(''),
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      1,
      'Cronômetro em andamento',
      'Tempo atual: $time',
      details,
    );
  }

  /// Notificação de volta
  static Future<void> showLapNotification(String lapTime, String totalTime) async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      'Volta registrada',
      'Volta: $lapTime\nTotal: $totalTime',
      details,
    );
  }

  /// Notificação de inatividade
  static Future<void> showInactiveNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronômetro',
      channelDescription: 'Notificações do cronômetro',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      2,
      'Cronômetro pausado',
      'Está parado há mais de 10s, deseja retomar?',
      details,
    );
  }

  /// Cancelar todas notificações
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
