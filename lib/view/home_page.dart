import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sqflitecred/provider/todo_provider.dart';
import 'package:sqflitecred/provider/update_provider.dart';
import 'add_update_screen.dart';
import '../models/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoProvider>().loadData();

    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text(
            "To do app",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          centerTitle: true,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.help_outline_rounded,
                size: 30,
              ),
            )
          ],
        ),
        body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            List<TodoModel> todoList = todoProvider.todoList;
            if (todoList.isEmpty) {
              return const Center(
                child: Text(
                  "No Tasks Found",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    int todoId = todoList[index].id!.toInt();
                    String todoTitle = todoList[index].title.toString();
                    String todoDesc = todoList[index].desc.toString();
                    String todoDt = todoList[index].dateAndTime.toString();

                    return Dismissible(
                      key: ValueKey<int>(todoId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.redAccent,
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        context.read<TodoProvider>().deleteTask(todoId);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white10,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 1,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  todoTitle,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              subtitle: Text(
                                todoDesc,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.8,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todoDt,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      context.go(
                                        '/addUpdateTask',
                                        extra: {
                                          'todoId': todoId,
                                          'todoTitle': todoTitle,
                                          'todoDesc': todoDesc,
                                        },
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_note,
                                      size: 28,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
            onPressed: () async {
              context.go('/addUpdateTask');
              final todoProvider =
                  Provider.of<UpdateProvider>(context, listen: false);
              todoProvider.clearFields();
            }));
  }
}
