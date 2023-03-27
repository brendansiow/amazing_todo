import 'package:amazing_todo/modules/add-edit-todo/page/add_edit_todo_page.dart';
import 'package:amazing_todo/modules/todo-list/page/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Amazing To-Do',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.amber,
              secondary: Colors.black,
            ),
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoListPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add-todo',
          builder: (BuildContext context, GoRouterState state) {
            return AddEditTodoPage();
          },
        ),
        GoRoute(
          path: 'edit-todo/:todoId',
          builder: (BuildContext context, GoRouterState state) {
            return AddEditTodoPage(
              todoId: state.params['todoId'],
            );
          },
        ),
      ],
    ),
  ],
);
