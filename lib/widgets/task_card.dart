import 'package:flutter/material.dart';
import '../models/tasks.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(task.description),
            const SizedBox(height: 6),
            Row(
              children: [
                Chip(
                  label: Text(task.category),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(task.priority),
                ),
                const SizedBox(width: 8),
                Text(
                  "Due: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}