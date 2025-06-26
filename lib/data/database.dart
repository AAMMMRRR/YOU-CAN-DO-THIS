import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];
  final String? userId;
  final _myBox = Hive.box('mybox');

  ToDoDatabase({this.userId});

  void createInitialData() {
    toDoList = [
      ['Have Breakfast', false],
      ['Attend meeting at 11 AM', false],
    ];
    updateDataBase();
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST_${userId ?? ''}') ?? [];
  }

  void updateDataBase() {
    _myBox.put('TODOLIST_${userId ?? ''}', toDoList);
  }
}
