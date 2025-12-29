import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TasksProvider(),
      child: const MyApp(),
    ),
  );
}

class TasksProvider extends ChangeNotifier {
  List<String> tasks = [];

  void addTask(String task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TasksProvider>().tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('Задач пока нет'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  onLongPress: () {
                    context
                        .read<TasksProvider>()
                        .removeTask(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<TasksProvider>()
              .addTask('Новая задача');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
