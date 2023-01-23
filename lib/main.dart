import 'package:flutter/material.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const LoginView(),
  ));
}
