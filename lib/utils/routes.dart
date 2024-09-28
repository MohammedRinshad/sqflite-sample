import 'package:go_router/go_router.dart';
import 'package:sqflitecred/view/home_page.dart';

import '../view/add_update_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/addUpdateTask',
      builder: (context, state) => AddUpdateTask(
        // You can pass optional parameters for tasks
        todoId: state.extra != null ? (state.extra as Map<String, dynamic>)['todoId'] : null,
        todoTitle: state.extra != null ? (state.extra as Map<String, dynamic>)['todoTitle'] : null,
        todoDesc: state.extra != null ? (state.extra as Map<String, dynamic>)['todoDesc'] : null,
      ),
    ),
  ],
);