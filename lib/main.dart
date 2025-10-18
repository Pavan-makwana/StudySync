import 'package:flutter/material.dart';
// Import your main application screens
import 'Screens/mainScreen.dart'; 
import 'Screens/login_screen.dart'; 
import 'Screens/signup_screen.dart'; 

// Placeholder classes needed for route definitions
class HomeScreen extends StatelessWidget { 
  final String userName;
  const HomeScreen({super.key, this.userName = 'User'});
  @override 
  Widget build(BuildContext context) => const Center(child: Text('Dashboard/Home Screen')); 
}
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text('Profile Screen')); }
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text('Settings Screen')); }
class ProgramListingScreen extends StatelessWidget { const ProgramListingScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text('Course Listing Screen')); }
class ProgramDetailsScreen extends StatelessWidget { const ProgramDetailsScreen({super.key}); @override Widget build(BuildContext context) => const Center(child: Text('Course Details Screen')); }


void main() {
  runApp(const StudySyncApp());
}

class StudySyncApp extends StatelessWidget { 
  const StudySyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudySync',
      debugShowCheckedModeBanner: false, 
      
      // Starting point is the main shell container
      initialRoute: '/app_shell',
      
      routes: {
        // The container with top/bottom bars (Mainscreen)
        '/app_shell': (context) => const Mainscreen(), // <-- Main landing page
        
        // Authentication Routes
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        
        // Content Routes (Used by the Bottom/Drawer menus)
        '/profile': (context) => const ProfileScreen(), 
        '/settings': (context) => const SettingsScreen(),
        '/programs': (context) => const ProgramListingScreen(),
        '/programDetails': (context) => const ProgramDetailsScreen(),
      },
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 1,
        ),
      ),
    );
  }
}