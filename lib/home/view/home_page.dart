import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Text(
                'Go Kart home page',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40),
              const TextButton(
                onPressed: _signOut,
                child: Text('Sign out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _signOut() async {
  try {
    await Supabase.instance.client.auth.signOut();
  } catch (e) {
    print(e);
  }
}
