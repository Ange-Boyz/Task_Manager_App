import 'package:flutter/material.dart';
import '../models/tasks.dart';
import '../widgets/task_card.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  String filter = "All";

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = "School";
  String priority = "Medium";

  DateTime selectedDate = DateTime.now();

  List<Task> get filteredTasks {
    if (filter == "Completed") {
      return tasks.where((task) => task.isCompleted).toList();
    }

    if (filter == "Pending") {
      return tasks.where((task) => !task.isCompleted).toList();
    }

    return tasks;
  }

  void addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                    ),
                  ),
                  DropdownButtonFormField(
                    value: category,
                    items: const [
                      DropdownMenuItem(
                        value: "School",
                        child: Text("School"),
                      ),
                      DropdownMenuItem(
                        value: "Personal",
                        child: Text("Personal"),
                      ),
                      DropdownMenuItem(
                        value: "Health",
                        child: Text("Health"),
                      ),
                    ],
                    onChanged: (value) {
                      category = value!;
                    },
                  ),
                  DropdownButtonFormField(
                    value: priority,
                    items: const [
                      DropdownMenuItem(
                        value: "High",
                        child: Text("High"),
                      ),
                      DropdownMenuItem(
                        value: "Medium",
                        child: Text("Medium"),
                      ),
                      DropdownMenuItem(
                        value: "Low",
                        child: Text("Low"),
                      ),
                    ],
                    onChanged: (value) {
                      priority = value!;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: sheetContext,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2030),
                      );

                      if (picked != null) {
                        selectedDate = picked;
                      }
                    },
                    child: const Text("Pick Due Date"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        return;
                      }

                      setState(() {
                        tasks.add(
                          Task(
                            title: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            priority: priority,
                            dueDate: selectedDate,
                          ),
                        );
                      });

                      titleController.clear();
                      descriptionController.clear();

                      Navigator.pop(sheetContext);
                    },
                    child: const Text("Add Task"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int completed =
        tasks.where((task) => task.isCompleted).length;

    double progress =
        tasks.isEmpty ? 0 : completed / tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        backgroundColor: const Color(0xFF0F4C5C),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == "date") {
                  tasks.sort(
                    (a, b) =>
                        a.dueDate.compareTo(b.dueDate),
                  );
                } else {
                  tasks.sort(
                    (a, b) => b.priority.compareTo(a.priority),
                  );
                }
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: "date",
                child: Text("Sort by Date"),
              ),
              PopupMenuItem(
                value: "priority",
                child: Text("Sort by Priority"),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFB84D),
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F4C5C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ${tasks.length}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Done: $completed",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: progress,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                filterButton("All"),
                filterButton("Pending"),
                filterButton("Completed"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredTasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No tasks available",
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (_, index) {
                        final task = filteredTasks[index];

                        return Dismissible(
                          key: Key(task.title),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.only(
                              right: 20,
                            ),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            setState(() {
                              tasks.remove(task);
                            });
                          },
                          child: TaskCard(
                            task: task,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      TaskDetailScreen(
                                    task: task,
                                    onDelete: () {
                                      setState(() {
                                        tasks.remove(task);
                                      });
                                    },
                                    onToggle: () {
                                      setState(() {
                                        task.isCompleted =
                                            !task
                                                .isCompleted;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget filterButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: filter == text
            ? const Color(0xFFFFB84D)
            : Colors.white,
      ),
      onPressed: () {
        setState(() {
          filter = text;
        });
      },
      child: Text(text),
    );
  }
}