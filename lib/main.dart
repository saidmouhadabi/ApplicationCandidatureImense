import 'package:flutter/material.dart';
import 'package:applicatiocandidature/screens/screen1.dart';
import 'package:applicatiocandidature/screens/splashscreen.dart'; // Assurez-vous que le chemin est correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 229, 255, 0)),
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Screen1()), // Définir Screen1 comme la page d'accueil
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SplashScreen();
  }
}
