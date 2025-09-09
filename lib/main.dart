<<<<<<< HEAD
import 'package:agoravaicronometro/services/Notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/stopwatch_viewmodel.dart';  // Importação correta
import 'view/stopwatch_page.dart';           // Importação correta

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   NotificationService.init(); 
    runApp(CronometroApp());
}

class CronometroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StopwatchViewModel()), // Fornecendo o ViewModel
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cronômetro de Voltas',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StopwatchPage(),  // Tela principal do cronômetro
      ),
    );
  }
}
=======

import 'package:agoravaicronometro/service/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/stopwatch_viewmodel.dart';  
import 'view/stopwatch_page.dart';           

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(CronometroApp());
}

class CronometroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StopwatchViewModel()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cronômetro de Voltas',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StopwatchPage(),  
      ),
    );
  }
}
>>>>>>> 7ff3e7fb17173a01e3a961452eca0c2634537888
