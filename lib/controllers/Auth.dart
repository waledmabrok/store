import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../views/login_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<void> signUpUser({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController rePasswordController,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        if (passwordController.text != rePasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }

        await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  static Future<void> loginUser({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // الانتقال إلى الشاشة الرئيسية
      Navigator.pushReplacementNamed(context, '/homeScreen');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Failed: ${e.message}')));
    }
  }
}
