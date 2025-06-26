import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/util/dialog_box.dart';
import 'package:to_do_list/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ToDoDatabase db;

  @override
  void initState() {
    super.initState();
    // Check if user is authenticated and email is verified
    final user = _auth.currentUser;
    if (user == null || !user.emailVerified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    } else {
      // Initialize database with user-specific key
      db = ToDoDatabase(userId: user.uid);
      if (_myBox.get('TODOLIST_${user.uid}') == null) {
        db.createInitialData();
      } else {
        db.loadData();
      }
    }
  }

  // Log out function
  Future<void> logOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void cancelTask() {
    setState(() {
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  void saveTask() {
    final taskText = _controller.text.trim();
    if (taskText.isNotEmpty) {
      setState(() {
        db.toDoList.add([taskText, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    } else {
      // Show feedback if the input is empty
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a task')));
    }
  }

  final _controller = TextEditingController();

  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: cancelTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading if db is not initialized (user is unauthenticated)
    if (_auth.currentUser == null || !(_auth.currentUser!.emailVerified)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text(
              "Today's Tasks",
              style: GoogleFonts.raleway(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 92, 74, 51),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: logOut,
              tooltip: 'Log Out',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
          backgroundColor: const Color.fromARGB(255, 92, 74, 51),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 244, 231, 214),
                Color.fromARGB(255, 203, 181, 155),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder:
                (context, index) => TodoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
