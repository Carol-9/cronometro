import 'dart:async';
import 'package:flutter/material.dart';
import '../service/notification.dart';

class Lap {
  final String lapTime;
  final String totalTime;

  Lap({required this.lapTime, required this.totalTime});
}

class StopwatchViewModel extends ChangeNotifier {
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  bool isRunning = false;

  List<Lap> laps = [];

  String get currentTime {
    final minutes = _currentDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _currentDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (_currentDuration.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds.$milliseconds";
  }

  // Inicializa notificações
  StopwatchViewModel() {
    NotificationService.init();
  }

  void startTimer() {
    if (isRunning) return;

    isRunning = true;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _currentDuration += Duration(milliseconds: 10);
      notifyListeners();

      // Atualiza a notificação persistente com o tempo atual
      NotificationService.showPersistentRunningNotification(currentTime);
    });

    notifyListeners();
  }

  void pauseTimer() {
    if (!isRunning) return;

    _timer?.cancel();
    isRunning = false;
    notifyListeners();

    // Cancela a notificação persistente
    NotificationService.cancelPersistentNotification();

    // Mostra sugestão para retomar
    NotificationService.showResumeSuggestion();
  }

  void resetTimer() {
    _timer?.cancel();
    _currentDuration = Duration.zero;
    laps.clear();
    isRunning = false;
    notifyListeners();

    // Cancela notificação persistente
    NotificationService.cancelPersistentNotification();
  }

  void recordLap() {
    final lapTime = currentTime;
    final totalTime = currentTime;
    laps.insert(0, Lap(lapTime: lapTime, totalTime: totalTime));
    notifyListeners();

    // Mostra notificação da volta
    NotificationService.showLapNotification(lapTime, totalTime);
  }
}
