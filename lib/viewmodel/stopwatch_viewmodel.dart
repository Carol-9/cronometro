import 'dart:async';
import 'package:flutter/foundation.dart';
import '../model/lap.dart';
import '../services/Notification.dart';

class StopwatchViewModel extends ChangeNotifier {
  late Timer _timer;
  Timer? _inactiveTimer; // Timer para notificação de inatividade
  int _milliseconds = 0;
  bool _isRunning = false;
  final List<Lap> _laps = [];

  List<Lap> get laps => _laps;
  String get currentTime => _formatTime(_milliseconds);
  bool get isRunning => _isRunning;

  void startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        _milliseconds += 100;
        notifyListeners();
      });
      _isRunning = true;
      notifyListeners();

      // Notificação persistente
      NotificationService.showPersistentRunningNotification(currentTime);

      // Cancelar timer de inatividade se houver
      _inactiveTimer?.cancel();
    }
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
      notifyListeners();

      // Inicia timer de 10s para notificação de inatividade
      _inactiveTimer = Timer(Duration(seconds: 10), () {
        NotificationService.showInactiveNotification();
      });
    }
  }

  void resetTimer() {
    _timer.cancel();
    _inactiveTimer?.cancel();
    _milliseconds = 0;
    _laps.clear();
    _isRunning = false;
    notifyListeners();
  }

  void recordLap() {
    final totalTime = _formatTime(_milliseconds);
    final lapTime = _laps.isEmpty
        ? totalTime
        : _formatTime(_milliseconds - _parseTime(_laps.last.totalTime));

    _laps.add(Lap(lapTime: lapTime, totalTime: totalTime));
    notifyListeners();

    // Notificação de volta
    NotificationService.showLapNotification(lapTime, totalTime);
  }

  String _formatTime(int milliseconds) {
    final seconds = (milliseconds / 1000).floor() % 60;
    final minutes = (milliseconds / 60000).floor() % 60;
    final hours = (milliseconds / 3600000).floor();

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int _parseTime(String formattedTime) {
    final parts = formattedTime.split(':').map(int.parse).toList();
    return (parts[0] * 3600 + parts[1] * 60 + parts[2]) * 1000;
  }
}
