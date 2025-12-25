class TaskModel {
  String id;
  String text;
  bool isDone;
  int colorValue;
  int createdAt;

  TaskModel({
    required this.id,
    required this.text,
    this.isDone = false,
    this.colorValue = 0xFFFFFFFF,
    required this.createdAt,
  });
}
