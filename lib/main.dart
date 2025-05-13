import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:testfire/views/Home.dart';
import 'package:testfire/views/OnBording.dart';
import 'package:testfire/views/Splash.dart';
import 'package:testfire/views/login_screen.dart';
import 'package:testfire/views/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service App',
      initialRoute: SplashScreen.routeName,
      routes: {
        // All routes for mobile (User + Admin)
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
