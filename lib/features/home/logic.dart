import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:taining/features/models/task.dart';
import 'status.dart';

class TasksCubit extends Cubit<HomeState> {
  TasksCubit() : super(HomeInitial()) {
    loadTasks();
  }

  List<TaskModel> tasks = [];
  late Box<TaskModel> box;

  final List<Color> taskColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  int _colorIndex = 0;

  Future<void> loadTasks() async {
    box = await Hive.openBox<TaskModel>('tasksBox');
    tasks = box.values.toList();
    emit(HomeLoaded());
  }

  Future<void> addTask(String text) async {
    if (text.trim().isEmpty) return;
    final color = taskColors[_colorIndex];
    _colorIndex = (_colorIndex + 1) % taskColors.length;

    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      colorValue: color.value,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await box.put(task.id, task);
    tasks.add(task);
    emit(HomeLoaded());
  }

  Future<void> toggleTask(String id, bool isDone) async {
    final task = box.get(id);
    if (task != null) {
      task.isDone = isDone;
      await task.save();
      emit(HomeLoaded());
    }
  }

  Future<void> deleteTask(String id) async {
    await box.delete(id);
    tasks.removeWhere((t) => t.id == id);
    emit(HomeLoaded());
  }

  // ✅ دالة جديدة لتعديل نص الـ Task
  Future<void> editTask(String id, String newText) async {
    final task = box.get(id);
    if (task != null && newText.trim().isNotEmpty) {
      task.text = newText;
      await task.save();
      final index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        tasks[index] = task;
      }
      emit(HomeLoaded());
    }
  }
}
