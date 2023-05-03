import 'package:flutter/material.dart';
import 'package:notepad/views/constants/routes.dart';
import 'package:notepad/views/hompage_view.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/notes_view.dart';
import 'package:notepad/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const Homepage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView()
    },
  ));
}
