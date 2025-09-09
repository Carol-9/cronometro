<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/stopwatch_viewmodel.dart';  

class StopwatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stopwatchViewModel = Provider.of<StopwatchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 142, 151),
        foregroundColor: const Color.fromARGB(255, 245, 243, 243),
        title: Text(' Cronômetro '),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto', 
        ),
      ),

      // Corpo do cronômetro
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Texto do cronômetro
          Center(
            child: Text(
              stopwatchViewModel.currentTime,
              style: TextStyle(
                fontSize: 150,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 12, 11, 14),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 30), // Espaçamento entre o cronômetro e os botões

          // Linha com os três botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os botões
            children: [
              // Botão Iniciar ou Pausar (Esquerda)
              ElevatedButton(
                onPressed: stopwatchViewModel.isRunning
                    ? stopwatchViewModel.pauseTimer
                    : stopwatchViewModel.startTimer,
                child: Text(
                  stopwatchViewModel.isRunning ? 'Pausar' : 'Iniciar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.black,         // Preto
                    fontSize: 28,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: stopwatchViewModel.isRunning
                      ? Colors.red
                      : const Color.fromARGB(255, 80, 241, 88),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                ),
              ),

              // Botão Reiniciar (Meio)
              ElevatedButton(
                onPressed: stopwatchViewModel.resetTimer,
                child: Text(
                  'Reiniciar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.black,         // Preto
                    fontSize: 28,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                ),
              ),

              // Botão Registrar Volta (Direita)
              ElevatedButton(
                onPressed: stopwatchViewModel.isRunning
                    ? stopwatchViewModel.recordLap
                    : null, // Desabilita se não estiver rodando
                child: Text(
                  'Registrar Volta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Negrito
                    color: Colors.black,         // Preto
                    fontSize: 28,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 59, 39, 129),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                ),
              ),
            ],
          ),

          SizedBox(height: 20), // Espaçamento entre botões e lista

          // Lista de voltas
          Expanded(
            child: ListView.builder(
              itemCount: stopwatchViewModel.laps.length,
              itemBuilder: (context, index) {
                final lap = stopwatchViewModel.laps[index];
                return ListTile(
                  title: Text('Volta ${index + 1} - ${lap.lapTime}'),
                  subtitle: Text('Tempo Total: ${lap.totalTime}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
=======
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
>>>>>>> 7ff3e7fb17173a01e3a961452eca0c2634537888
