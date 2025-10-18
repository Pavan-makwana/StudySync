import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final bool isLoggedIn;

  const DrawerMenu({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'StudySync Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          
          if (isLoggedIn) ...[
            // Home (Dashboard)
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); 
                // Navigate to the main application shell and clear all other routes
                Navigator.pushNamedAndRemoveUntil(context, '/app_shell', (route) => false); 
              },
            ),
            // Courses (Program Listing)
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Courses'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/programs');
              },
            ),
            // Profile
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            // Settings
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(),
            // About
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ] 
          
          else ...[
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context); 
                // Navigate to the Login Screen
                Navigator.pushNamed(context, '/login'); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pop(context); 
                // Navigate to the Sign Up Screen
                Navigator.pushNamed(context, '/signup'); 
              },
            ),
          ],
        ],
      ),
    );
  }
}