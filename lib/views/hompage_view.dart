import 'package:flutter/material.dart';
import 'package:notepad/services/auth/auth_services.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/notes_view.dart';
import 'package:notepad/views/verify_email_view.dart';
import '../firebase_options.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = AuthService.firebase().currentUser;
                if (user != null) {
                  if (user.isEmailVerified) {
                    return const NotesView();
                  } else {
                    return const VerifyEmailView();
                  }
                } else {
                  return const LoginView();
                }

              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
