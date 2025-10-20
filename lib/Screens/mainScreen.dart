// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import './drawer_menu.dart';

// Replace the simple blue with a learning-focused gradient + accents
const primaryColor1 = Color(0xFF6C63FF); // violet
const accentColor = Color(0xFF00D4FF); // cyan
const kHeaderGradient = LinearGradient(
  colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class Task {
  String id;
  String title;
  String? description;
  DateTime? dueDate;
  bool done;
  DateTime createdAt;
  DateTime? reminderAt;
  String? groupId;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.done = false,
    DateTime? createdAt,
    this.reminderAt,
    this.groupId,
  }) : createdAt = createdAt ?? DateTime.now();
}

class GroupWorkspace {
  String id;
  String name;
  String joinCode;
  String? description;
  List<String> memberIds;

  GroupWorkspace({
    required this.id,
    required this.name,
    required this.joinCode,
    this.description,
    List<String>? memberIds,
  }) : memberIds = memberIds ?? [];
}

class Course {
  String id;
  String title;
  String instructor;
  String description;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.description,
  });
}

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

  // In-memory app state for demo features
  final List<Task> _tasks = [];
  final List<GroupWorkspace> _groups = [];
  final List<Course> _courses = [];
  int dailyGoal = 3; // tasks per day target
  int completedToday = 0;
  int streakCount = 0;
  DateTime? lastStreakDate;

  // helper to safely format nullable DateTime to a short local date string
  String _formatDateShort(DateTime? dt) {
    if (dt == null) return 'No date';
    return dt.toLocal().toString().split(' ')[0];
  }
  
  @override
  void initState() {
    super.initState();
    // Seed demo content
    _seedDemoData();
  }

  void _seedDemoData() {
    _courses.addAll([
      Course(
        id: 'c1',
        title: 'Flutter for Beginners',
        instructor: 'Pavan Makwana',
        description: 'Get started with Flutter: widgets, layouts, and basic app structure.',
      ),
      Course(
        id: 'c2',
        title: 'State Management in Flutter',
        instructor: 'Ian Maina',
        description: 'Learn Provider, Riverpod, and Bloc patterns to manage app state efficiently.',
      ),
      Course(
        id: 'c3',
        title: 'Building Responsive UIs with Flutter',
        instructor: 'Sai Rishitha',
        description: 'Techniques for adaptive layouts, media queries, and platform-aware design.',
      ),
    ]);

    _groups.add(
      GroupWorkspace(
        id: 'g1',
        name: 'Flutter App Project',
        joinCode: 'MAD2025',
        description: 'Group for the semester-long project',
        memberIds: ['u1', 'u2'],
      ),
    );

    _tasks.addAll([
      Task(
        id: 't1',
        title: 'Prepare for AI Quiz',
        description: 'Review lecture notes and practice problems.',
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Task(
        id: 't2',
        title: 'Read Chapter 3',
        dueDate: DateTime.now(),
      ),
    ]);
  }

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

  // mark task done/undone and update progress/streaks
  void _toggleTaskDone(Task task) {
    setState(() {
      task.done = !task.done;
      final today = DateTime.now();
      final isDueToday = task.dueDate == null ||
          (task.dueDate!.year == today.year &&
              task.dueDate!.month == today.month &&
              task.dueDate!.day == today.day);

      if (isDueToday) {
        completedToday += task.done ? 1 : -1;
        if (completedToday < 0) completedToday = 0;
      }

      // simple streak logic: if completedToday reached dailyGoal and lastStreakDate != today
      final todayKey = DateTime(today.year, today.month, today.day);
      if (completedToday >= dailyGoal && (lastStreakDate == null || lastStreakDate!.isBefore(todayKey))) {
        streakCount += 1;
        lastStreakDate = todayKey;
        // show a snack congratulating user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Streak continued! $streakCount days 🎉')),
        );
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

  // UI: Dashboard/Home Content
  Widget _buildDashboard() {
    final today = DateTime.now();
    final todaysTasks = _tasks.where((t) {
      if (t.dueDate == null) return true;
      return t.dueDate!.year == today.year &&
          t.dueDate!.month == today.month &&
          t.dueDate!.day == today.day;
    }).toList();

    final progress = (dailyGoal == 0) ? 0.0 : (completedToday / dailyGoal).clamp(0.0, 1.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // New hero header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: kHeaderGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                // use fractional double for alpha (withValues expects double)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Focus on what matters',
                        style: TextStyle(
                          // replace deprecated withOpacity usage with withValues(double)
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Track tasks, build streaks, and collaborate with your team',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showTaskDialog(),
                  child: const Text('Add Task'),
                )
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Welcome back, $_userName!', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Text('Streak', style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('$streakCount days', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        const Text('Keep it up!'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Card(
                elevation: 2,
                child: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        color: primaryColor1,
                        strokeWidth: 10,
                        backgroundColor: Colors.grey.shade200,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${(progress * 100).round()}%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text('Today', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Today\'s Tasks', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (todaysTasks.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('No tasks for today. Add a new one using +', textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showTaskDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Create Task'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...todaysTasks.map((t) => Card(
                  child: ListTile(
                    leading: Checkbox(value: t.done, onChanged: (_) => _toggleTaskDone(t)),
                    title: Text(t.title, style: TextStyle(decoration: t.done ? TextDecoration.lineThrough : null)),
                    subtitle: Text(t.dueDate != null ? 'Due: ${_formatDateShort(t.dueDate)}' : 'No due date'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') _showTaskDialog(editTask: t);
                        if (value == 'delete') _deleteTask(t);
                      },
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
                )),
          const SizedBox(height: 18),
          const Text('Progress Analytics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Text('Completion charts and detailed analytics will be available soon.'),
                  SizedBox(height: 12),
                  Text('For now, track your daily goal and streak.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Courses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ..._courses.map((c) => Card(
                child: ListTile(
                  leading: const Icon(Icons.book, color: primaryColor1),
                  title: Text(c.title),
                  subtitle: Text('Instructor: ${c.instructor}'),
                  onTap: () => _showCourseDetails(c),
                ),
              )),
          const SizedBox(height: 12),

          // NEW: View All Courses button under dashboard courses
          ElevatedButton.icon(
            onPressed: () => _viewAllCourses(),
            icon: const Icon(Icons.view_list),
            label: const Text('View All Courses'),
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor1),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  void _showCourseDetails(Course c) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(c.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Instructor: ${c.instructor}'),
            const SizedBox(height: 8),
            Text(c.description),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  // Groups / Workspaces UI
  Widget _buildGroups() {
    return _isLoggedIn
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('Group Workspaces', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
                    ElevatedButton.icon(
                      onPressed: () => _showCreateGroupDialog(),
                      icon: const Icon(Icons.group_add),
                      label: const Text('Create'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _groups.isEmpty
                      ? Center(child: const Text('No groups yet. Create one to collaborate.'))
                      : ListView.builder(
                          itemCount: _groups.length,
                          itemBuilder: (ctx, i) {
                            final g = _groups[i];
                            return Card(
                              child: ListTile(
                                title: Text(g.name),
                                subtitle: Text('Join Code: ${g.joinCode} · Members: ${g.memberIds.length}'),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'open') _openGroup(g);
                                    if (value == 'delete') _deleteGroup(g);
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(value: 'open', child: Text('Open')),
                                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                                  ],
                                ),
                                onTap: () => _openGroup(g),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          )
        : _buildLoginPrompt();
  }

  void _openGroup(GroupWorkspace g) {
    // Minimal group workspace view
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(g.name),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(g.description ?? 'No description'),
              const SizedBox(height: 12),
              Text('Join Code: ${g.joinCode}'),
              const SizedBox(height: 12),
              const Text('Shared task board (basic):'),
              const SizedBox(height: 8),
              // list of tasks that belong to this group
              if (_tasks.where((t) => t.groupId == g.id).isEmpty)
                const Text('No shared tasks yet.')
              else
                Column(
                  children: _tasks.where((t) => t.groupId == g.id).map((t) {
                    return ListTile(
                      leading: Checkbox(value: t.done, onChanged: (_) => _toggleTaskDone(t)),
                      title: Text(t.title),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close'))],
      ),
    );
  }

  // Settings / Reminders UI
  Widget _buildSettings() {
    return _isLoggedIn
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('Daily Goal'),
                  subtitle: Text('Complete $dailyGoal tasks per day'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (dailyGoal > 1) dailyGoal--;
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() {
                        dailyGoal++;
                      }),
                    ),
                  ]),
                ),
                ListTile(
                  title: const Text('Reminders'),
                  subtitle: const Text('Enable/disable in-app reminder simulation'),
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {
                      // placeholder: real notifications require flutter_local_notifications or firebase
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reminder settings are placeholders.'))); 
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Progress Analytics (coming soon)'),
                    subtitle: const Text('Charts and historical progress will appear here in a future update.'),
                  ),
                ),
              ],
            ),
          )
        : _buildLoginPrompt();
  }

  void _deleteTask(Task t) {
    setState(() {
      if (t.done) {
        // if done and due today, decrement completedToday
        final today = DateTime.now();
        if (t.dueDate != null &&
            t.dueDate!.year == today.year &&
            t.dueDate!.month == today.month &&
            t.dueDate!.day == today.day) {
          completedToday = (completedToday - 1).clamp(0, 9999);
        }
      }
      _tasks.removeWhere((e) => e.id == t.id);
    });
  }

  void _deleteGroup(GroupWorkspace g) {
    setState(() {
      // detach tasks from this group
      for (var t in _tasks.where((t) => t.groupId == g.id)) {
        t.groupId = null;
      }
      _groups.removeWhere((gg) => gg.id == g.id);
    });
  }

  Future<void> _showTaskDialog({Task? editTask}) async {
    final titleCtrl = TextEditingController(text: editTask?.title ?? '');
    final descCtrl = TextEditingController(text: editTask?.description ?? '');
    DateTime? due = editTask?.dueDate;
    String? groupId = editTask?.groupId;
    DateTime? reminder = editTask?.reminderAt;

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(editTask == null ? 'Create Task' : 'Edit Task'),
          content: StatefulBuilder(builder: (context2, setLocal) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Text(due == null ? 'No due date' : 'Due: ${_formatDateShort(due)}')),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context2,
                            initialDate: due ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setLocal(() => due = picked);
                        },
                        child: const Text('Pick'),
                      ),
                      if (due != null)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setLocal(() => due = null),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String?>(
                    initialValue: groupId,
                    items: [const DropdownMenuItem(value: null, child: Text('No group')), ..._groups.map((g) => DropdownMenuItem(value: g.id, child: Text(g.name)))],
                    onChanged: (v) => setLocal(() => groupId = v),
                    decoration: const InputDecoration(labelText: 'Assign to group (optional)'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Text(reminder == null ? 'No reminder' : 'Remind: ${_formatDateShort(reminder)}')),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context2,
                            initialDate: reminder ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setLocal(() => reminder = picked);
                        },
                        child: const Text('Set'),
                      ),
                      if (reminder != null)
                        IconButton(icon: const Icon(Icons.clear), onPressed: () => setLocal(() => reminder = null)),
                    ],
                  ),
                ],
              ),
            );
          }),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final title = titleCtrl.text.trim();
                if (title.isEmpty) return;
                setState(() {
                  if (editTask != null) {
                    editTask.title = title;
                    editTask.description = descCtrl.text.trim();
                    editTask.dueDate = due;
                    editTask.groupId = groupId;
                    editTask.reminderAt = reminder;
                  } else {
                    final newTask = Task(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      description: descCtrl.text.trim(),
                      dueDate: due,
                      reminderAt: reminder,
                      groupId: groupId,
                    );
                    _tasks.add(newTask);
                  }
                });

                if (reminder != null) {
                  // placeholder for scheduling a real notification
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reminder set for ${_formatDateShort(reminder)}')));
                }

                Navigator.pop(ctx);
              },
              child: Text(editTask == null ? 'Create' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCreateGroupDialog() async {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create Group'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Group name')),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              setState(() {
                final group = GroupWorkspace(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  joinCode: (name.substring(0, name.length.clamp(2, 6))).toUpperCase() + DateTime.now().millisecondsSinceEpoch.toString().substring(6),
                  description: descCtrl.text.trim(),
                );
                _groups.add(group);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Create'),
          ),
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
      // Featured => Courses
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Courses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (ctx, i) {
                  final c = _courses[i];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: kHeaderGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.book, color: Colors.white),
                      ),
                      title: Text(c.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Instructor: ${c.instructor}'),
                      onTap: () => _showCourseDetails(c),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
            // NEW: View All Courses button on Featured screen
            ElevatedButton.icon(
              onPressed: () => _viewAllCourses(),
              icon: const Icon(Icons.view_list),
              label: const Text('View All Courses'),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor1),
            ),
          ],
        ),
      ),

      // Dashboard (Learning)
      _isLoggedIn ? _buildDashboard() : _buildLoginPrompt(),

      // Wishlist -> Group Workspaces
      _isLoggedIn ? _buildGroups() : _buildLoginPrompt(),

      // Settings
      _isLoggedIn ? _buildSettings() : _buildLoginPrompt(),
    ];

    return Scaffold(
      // Top Navigation Bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // non-const so we can use theme colors
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: kHeaderGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text('StudySync', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
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
        elevation: 0,
        centerTitle: false,
      ),

      // Drawer Menu: Direct reference to the state variable.
      endDrawer: DrawerMenu(isLoggedIn: _isLoggedIn),

      // Body content changes based on the BottomNavigationBar
      body: bodyWidgets.elementAt(_selectedIndex),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor1,
        child: const Icon(Icons.add),
        onPressed: () {
          if (!_isLoggedIn) {
            Navigator.pushNamed(context, '/login');
            return;
          }
          if (_selectedIndex == 1) {
            // Dashboard -> create task
            _showTaskDialog();
          } else if (_selectedIndex == 2) {
            // Groups -> create group
            _showCreateGroupDialog();
          } else if (_selectedIndex == 0) {
            // Courses -> create course (quick scaffold)
            _createCourseQuick();
          } else {
            // Settings -> create task as default
            _showTaskDialog();
          }
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor1,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Featured'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_filled), label: 'Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  void _createCourseQuick() {
    // quick scaffold to add a course
    final titleCtrl = TextEditingController();
    final instrCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: instrCtrl, decoration: const InputDecoration(labelText: 'Instructor')),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final title = titleCtrl.text.trim();
              if (title.isEmpty) return;
              setState(() {
                _courses.add(Course(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, instructor: instrCtrl.text.trim(), description: descCtrl.text.trim()));
              });
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // Helper: show all courses in a bottom sheet
  void _viewAllCourses() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text('All Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _courses.isEmpty
                    ? const Center(child: Text('No courses available'))
                    : ListView.separated(
                        itemCount: _courses.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (ctx2, i) {
                          final c = _courses[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primaryColor1,
                              child: const Icon(Icons.book, color: Colors.white, size: 20),
                            ),
                            title: Text(c.title),
                            subtitle: Text(c.instructor),
                            onTap: () {
                              Navigator.pop(ctx);
                              _showCourseDetails(c);
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
