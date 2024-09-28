import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitecred/provider/todo_provider.dart';
import 'package:sqflitecred/provider/update_provider.dart';
import 'package:sqflitecred/utils/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        )),
        routerConfig: router,
      ),
    );
  }
}
