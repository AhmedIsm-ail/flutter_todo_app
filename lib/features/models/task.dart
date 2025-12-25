import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  int colorValue;

  @HiveField(4)
  int createdAt;

  TaskModel({
    required this.id,
    required this.text,
    this.isDone = false,
    this.colorValue = 0xFFFFFFFF,
    required this.createdAt,
  });
}
