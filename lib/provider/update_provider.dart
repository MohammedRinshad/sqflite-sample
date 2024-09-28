import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflitecred/models/model.dart';
import '../database/db_handler.dart';

class UpdateProvider extends ChangeNotifier {
  final DataBaseHelper _dbHelper = DataBaseHelper();

  Future<List<TodoModel>> getDataList() async {
    return await _dbHelper.getDataList();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // Add a new task
  Future<void> addTask() async {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      await _dbHelper.insert(TodoModel(
        title: titleController.text,
        desc: descController.text,
        dateAndTime: DateFormat('yMd').add_jm().format(DateTime.now()).toString(),
      ));
      clearFields();
      notifyListeners();
    }
  }

  Future<void> updateTask(TodoModel todoModel) async {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      TodoModel updatedTodo = TodoModel(
        id: todoModel.id,  // Ensure you pass the existing task ID
        title: titleController.text,
        desc: descController.text,
        dateAndTime: DateFormat('yMd').add_jm().format(DateTime.now()).toString(),
      );
      await _dbHelper.update(updatedTodo);  // Call the update method
      clearFields();
      notifyListeners();
    }
  }

  // Clear the fields
  void clearFields() {
    titleController.clear();
    descController.clear();
    notifyListeners();
  }

  // Load data for update
  void loadTaskData(String title, String desc) {
    titleController.text = title;
    descController.text = desc;
    notifyListeners();
  }
}
