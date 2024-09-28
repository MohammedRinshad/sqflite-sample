import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sqflitecred/models/model.dart';
import 'package:sqflitecred/provider/update_provider.dart';
import 'package:sqflitecred/widgets/button_widget.dart';
import 'package:sqflitecred/widgets/text_field.dart';

// Import your provider

class AddUpdateTask extends StatelessWidget {
  //bool isUpdate;
  int? todoId;
  String? todoTitle;
  String? todoDesc;
  String? todoDt;
  bool? update;
  AddUpdateTask(
      {super.key, this.todoId, this.todoTitle, this.todoDesc, this.todoDt});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<UpdateProvider>(context, listen: true);

    if (todoTitle != null) {
      todoProvider.titleController.text = todoTitle!;
    }
    if (todoDesc != null) {
      todoProvider.descController.text = todoDesc!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Task",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormFieldWidget(
                          height: 100,
                          keyboardType: TextInputType.text,
                          maxLines: 2,
                          minLines: 1,
                          labelText: 'Note Title',
                          controller: todoProvider.titleController,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormFieldWidget(
                          height: 150,
                          keyboardType: TextInputType.text,
                          maxLines: 10,
                          minLines: 5,
                          labelText: 'Write notes here',
                          controller: todoProvider.descController,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonWidget(
                          title: 'Save',
                          color: Colors.red,
                          press: () {
                            if (todoId != null) {
                              // Update the task if todoId is present
                              todoProvider.updateTask(
                                TodoModel(
                                  id: todoId!,
                                  title: todoProvider.titleController.text,
                                  desc: todoProvider.descController.text,
                                  dateAndTime:
                                      todoDt ?? DateTime.now().toString(),
                                ),
                              );
                              context.go('/');
                            } else {
                              todoProvider.addTask();
                              context.go('/');
                            }
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
