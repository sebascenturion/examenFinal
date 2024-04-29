import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication_model.dart';
import '../screens/login_screen.dart'; // Asegúrate de que tienes este archivo correctamente enlazado

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthenticationModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Tu pantalla de inicio de sesión inicial
    );
  }
}
