// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert'; // Required for jsonDecode
import 'package:http/http.dart' as http; // Required for API calls

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _mockApiBaseUrl = 'https://68f34f12fd14a9fcc428651a.mockapi.io/user'; 

  void _login() async { 
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final url = Uri.parse('$_mockApiBaseUrl?email=$email');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List<dynamic> users = jsonDecode(response.body);

          if (users.isNotEmpty) {
            final Map<String, dynamic> user = users.first; 
            
            final storedPassword = user['password'] as String?; 
            final storedName = user['fname'] as String?; 
            
            if (storedPassword != null && storedPassword == password) {
              
              final userName = (storedName?.isNotEmpty == true) ? storedName! : 'Student';
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Successful! Welcome back, $userName.')),
              );
              
              
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/app_shell', 
                (route) => false,
                arguments: { 
                  'isLoggedIn': true,
                  'userName': userName,
                },
              );
              
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid Credentials. Please try again.')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not found. Please sign up.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed. Server error: ${response.statusCode}')),
          );
        }
      } catch (e, st) {
        print('LOGIN ERROR: $e');
        print('STACK TRACE: $st');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred during login. Check console for details.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StudySync Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50),
              // Logo/Title placeholder
              const Center(
                child: Text('StudySync', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              const SizedBox(height: 50),

              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Login Button
              ElevatedButton(
                onPressed: _login, 
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: const Text('LOGIN', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              
              const SizedBox(height: 24),
              // Link to Sign Up
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}