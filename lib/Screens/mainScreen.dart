// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import './drawer_menu.dart'; 

const primaryColor1 = Colors.blue;

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  // Static method to safely access and change the state (kept for safety/legacy)
  static _MainscreenState? of(BuildContext context) => 
      context.findAncestorStateOfType<_MainscreenState>();

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _selectedIndex = 1; // Start on the 'Learning' tab (index 1), which will be the Dashboard
  bool _isLoggedIn = false; 
  String _userName = 'Student'; // Placeholder for the user's name
  
  bool _didInit = false; // Flag to ensure the check runs only once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      _didInit = true;
      _checkLoginArguments();
    }
  }

  void _checkLoginArguments() {
    // ModalRoute.of(context) gives us access to the arguments passed during navigation
    final args = ModalRoute.of(context)?.settings.arguments;
    
    // Check if arguments were passed after a successful login
    if (args != null && args is Map<String, dynamic> && args['isLoggedIn'] == true) {
      // Use setState to update the state of the NEW Mainscreen instance
      setState(() {
        _isLoggedIn = true;
        _userName = args['userName'] as String? ?? 'Student';
        _selectedIndex = 1; // Ensure the user lands on the dashboard tab
      });
    }
  }

  // Public method to be called from Login/SignUp Screen (kept for safety)
  void setLoggedIn(bool value, {String? name}) {
    setState(() {
      _isLoggedIn = value;
      // If logging in, reset the selected tab to the Home/Dashboard tab (index 1)
      if (value) {
        _selectedIndex = 1; 
        if (name != null && name.isNotEmpty) {
          _userName = name;
        }
      }
    });
  }

  // Helper widget for content when the user is logged out
  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please Log In to access this feature.', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }

  // The actual Dashboard/Home Content
  Widget _buildDashboard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome back, $_userName!', 
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Task Progress Circle (from wireframe)
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor1, width: 6),
            ),
            alignment: Alignment.center,
            child: const Text('New Task!', style: TextStyle(fontSize: 20, color: primaryColor1, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 20),
          const Text('Your progress is waiting!', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the content for the body based on the selected index and login state
    final List<Widget> bodyWidgets = [
      const Center(child: Text('Featured Courses', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
      _isLoggedIn ? _buildDashboard() : _buildLoginPrompt(), // Learning/Dashboard tab
      _isLoggedIn ? const Center(child: Text('Your Wishlist', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))) : _buildLoginPrompt(),
      _isLoggedIn ? const Center(child: Text('App Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))) : _buildLoginPrompt(),
    ];
        
    return Scaffold(
      // Top Navigation Bar
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Row(
          children: [
            Icon(Icons.school, color: primaryColor1),
            SizedBox(width: 8),
            Text('StudySync', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)), 
          ],
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: primaryColor1,
                onPressed: () => Scaffold.of(context).openEndDrawer(), 
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1, 
      ),
      
      // Drawer Menu: Direct reference to the state variable.
      endDrawer: DrawerMenu(isLoggedIn: _isLoggedIn), 
      
      // Body content changes based on the BottomNavigationBar
      body: bodyWidgets.elementAt(_selectedIndex),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor1,
        unselectedItemColor: Colors.grey, 
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Featured'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_filled), label: 'Learning'), // Dashboard is here
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}