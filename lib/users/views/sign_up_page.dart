// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/app/repository/auth_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Image.asset('assets/logo/round/152.png'),
              ),
              const SizedBox(height: 40),
              Align(
                child: Text(
                  'Sign up to Go Kart',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Align(
                child: Text(
                  'Welcome!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(height: 40),
              _emailInput(_emailController),
              const SizedBox(height: 10),
              _passwordInput(_passwordController),
              const SizedBox(height: 20),
              _signUpButton(
                context,
                _emailController,
                _passwordController,
              ),
              const SizedBox(height: 20),
              _backButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signUpButton(
  BuildContext context,
  TextEditingController email,
  TextEditingController password,
) {
  return ElevatedButton(
    onPressed: () async {
      try {
        if (email.text.isEmpty || password.text.isEmpty) {
          CommonUtils.showSnackBar(
            context,
            'Please fill in all fields',
            isError: true,
          );
        } else {
          final authRepository = GetIt.I.get<AuthRepository>();
          await authRepository.signUpEmailAndPassword(
            email.text,
            password.text,
          );
          CommonUtils.showSnackBar(context, 'Signed up successfully');
          Navigator.pop(context);
        }
      } catch (error) {
        CommonUtils.showSnackBar(context, error.toString(), isError: true);
      }
    },
    child: const Text('Sign up'),
  );
}

Widget _emailInput(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(labelText: 'Email'),
  );
}

Widget _passwordInput(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(labelText: 'Password'),
    obscureText: true,
  );
}

Widget _backButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text('Back'),
  );
}
