import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF0F4C5C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFFB84D),
              child: Text(
                "AB",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Your Full Name",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Student ID: SE12345",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Software Engineering",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "I am passionate about mobile development and software engineering. I enjoy building modern applications and learning new technologies.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 25),
            Text(
              "Top Goals This Semester",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Improve Flutter skills"),
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Complete all assignments"),
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Build real-world projects"),
            ),
          ],
        ),
      ),
    );
  }
}