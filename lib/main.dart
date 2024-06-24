import 'package:assignment_reposoft/screens/home_screen.dart';
import 'package:assignment_reposoft/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      //for APP initialize in main & web in future
      options: const FirebaseOptions(
          apiKey: "AIzaSyBG4zVqMJ7sd6ZvGKkryAdf2be0mdYkGh4",
          projectId: "signin-signup-60421",
          messagingSenderId: "100706700423",
          appId: "1:100706700423:web:5b454d27f516f5836d7c22"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'Poppins',
        ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user != null) {
              return const HomeScreen();
            } else {
              return const SignUp();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
     // initialRoute: '/',
      
    );
  }
}
