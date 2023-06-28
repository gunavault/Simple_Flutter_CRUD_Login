import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:flutter_crud/main.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.104/flutterapi/crudflutter/register.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data == 'Success') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Success'),
            content: const Text('Your registration was successful!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ); // Navigate back to LoginPage
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Registration failed, do something
      }
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                await registerUser(email, password);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
