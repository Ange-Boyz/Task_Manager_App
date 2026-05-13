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
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: const Color(0xFFFFB84D),
                          child: const Text(
                            "AB",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Your Full Name",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Student ID: SE12345",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Software Engineering",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (sheetContext) {
                                final nameController = TextEditingController(text: "Tchomakam Ange Cabrel");
                                final idController = TextEditingController(text: "LMUI250967");
                                final deptController = TextEditingController(text: "Software Engineering");
                                final bioController = TextEditingController(text: "I am passionate about mobile development, AI and software engineering. I enjoy building modern applications and learning new technologies.");

                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 20,
                                    bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(labelText: "Full name"),
                                        ),
                                        TextField(
                                          controller: idController,
                                          decoration: const InputDecoration(labelText: "Student ID"),
                                        ),
                                        TextField(
                                          controller: deptController,
                                          decoration: const InputDecoration(labelText: "Department"),
                                        ),
                                        TextField(
                                          controller: bioController,
                                          maxLines: 3,
                                          decoration: const InputDecoration(labelText: "Bio"),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(sheetContext);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Profile updated')),
                                            );
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "I am passionate about mobile development and software engineering. I enjoy building modern applications and learning new technologies.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Top Goals This Semester",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.check_circle, color: Color(0xFF0F4C5C)),
                      title: Text("Improve My Design Thinking Skill"),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.check_circle, color: Color(0xFF0F4C5C)),
                      title: Text("Complete all assignments and Pass my exams"),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.check_circle, color: Color(0xFF0F4C5C)),
                      title: Text("Build real-world projects"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}