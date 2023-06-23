import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/auth_provider.dart';

import 'login.dart';
import 'home.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: AuthProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Apple',
          theme: ThemeData(
            // This is the theme of your application.
            //

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            // useMaterial3: true,
          ),
          routes: {
            '/': (context) => const LoginPage(),
            '/home': (context) => const MyHomePage(title: 'AppleYard'),
            '/register': (context) => const Register(),
          },
        ));
  }
}
