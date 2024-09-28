import 'package:flutter/material.dart';
import '../database/db_handler.dart';
import '../models/model.dart';

class TodoProvider extends ChangeNotifier {
  DataBaseHelper dbHelper = DataBaseHelper();
  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  Future<void> loadData() async {
    _todoList = await dbHelper.getDataList();
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await dbHelper.delete(id);
    await loadData();
  }
}
