import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notepad/views/login_view.dart';
import 'package:notepad/views/verify_email_view.dart';

import '../firebase_options.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.blueAccent),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  // final user = FirebaseAuth.instance.currentUser;
                  // if (user?.emailVerified ?? false) {
                  //   return const Text('Done');
                  // } else {
                  //   return const VerifyEmailView();
                  // }
                  return LoginView();
                  

                default:
                  return const Text('Loading....');
              }
            }),
      ),
    );
  }
}
