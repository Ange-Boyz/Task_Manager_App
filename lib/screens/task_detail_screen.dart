import 'package:flutter/material.dart';
import '../models/tasks.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  final ValueChanged<Task> onEdit;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: const Color(0xFF0F4C5C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(task.description),
            const SizedBox(height: 20),
            Text("Category: ${task.category}"),
            Text("Priority: ${task.priority}"),
            Text(
              "Due Date: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Task"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F4C5C),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (sheetContext) {
                          final titleController = TextEditingController(text: task.title);
                          final descriptionController = TextEditingController(text: task.description);

                          String category = task.category;
                          String priority = task.priority;
                          DateTime selectedDate = task.dueDate;

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
                                        initialDate: selectedDate,
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
                                      if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                                        return;
                                      }

                                      task.title = titleController.text;
                                      task.description = descriptionController.text;
                                      task.category = category;
                                      task.priority = priority;
                                      task.dueDate = selectedDate;

                                      onEdit(task);

                                      Navigator.pop(sheetContext);
                                    },
                                    child: const Text("Save Changes"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F4C5C),
                    ),
                    onPressed: () {
                      onToggle();
                      Navigator.pop(context);
                    },
                    child: Text(
                      task.isCompleted ? "Mark Incomplete" : "Mark Complete",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Delete Task"),
                    content: const Text(
                      "Are you sure you want to delete this task?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          onDelete();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Delete Task"),
            ),
          ],
        ),
      ),
    );
  }
}