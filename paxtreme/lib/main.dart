import 'package:flutter/material.dart';
import 'package:paxtreme/splash_screen.dart';
import 'package:paxtreme/Login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
            title: 'Paxtreme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
       routes: {
        '/lib/login.dart': (context) => const Login(),
      }, 
    );
  }
}