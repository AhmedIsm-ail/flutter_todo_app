import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taining/features/models/task.dart';
import 'status.dart';

class TasksCubit extends Cubit<HomeState> {
  TasksCubit() : super(HomeInitial());

  // In-memory list (no persistence)
  final List<TaskModel> tasks = [];

  final List<Color> taskColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  int _colorIndex = 0;

  void addTask(String text) {
    if (text.trim().isEmpty) return;

    final color = taskColors[_colorIndex];
    _colorIndex = (_colorIndex + 1) % taskColors.length;

    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      colorValue: color.value,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    tasks.add(task);
    emit(HomeLoaded());
  }

  void toggleTask(String id, bool isDone) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index].isDone = isDone;
      emit(HomeLoaded());
    }
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    emit(HomeLoaded());
  }

  void editTask(String id, String newText) {
    if (newText.trim().isEmpty) return;

    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index].text = newText;
      emit(HomeLoaded());
    }
  }
}
