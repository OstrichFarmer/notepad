import 'package:flutter/material.dart';
import 'package:notepad/services/auth/auth_exceptions.dart';
import 'package:notepad/services/auth/auth_services.dart';
import 'package:notepad/utilities/show_error_dialog.dart';
import 'package:notepad/views/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Register',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.lightBlueAccent,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your Email',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _password,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  cursorColor: Colors.lightBlueAccent,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Enter your Password',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final email = _email.text;
                      final password = _password.text;
                      await AuthService.firebase()
                          .createUser(email: email, password: password);

                      AuthService.firebase().sendEmailVerification();
                      if (mounted) {
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      }
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Weak password',
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                        'Email is already in use',
                      );
                    } on InvalidAuthException {
                      await showErrorDialog(
                        context,
                        'This is an invalid email address',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(context, "Registration Failed");
                    }
                  },
                  child: const Text('Register'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute, (route) => false);
                        },
                        child: const Text('Click here'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
