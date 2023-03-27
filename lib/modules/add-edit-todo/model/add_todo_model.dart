import 'package:amazing_todo/modules/common/domain/todo.dart';
import 'package:amazing_todo/modules/todo-list/model/todo_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

final addTodoProvider = Provider<AddTodoModel>((ref) => AddTodoModel(ref));

var uuid = const Uuid();

class AddTodoModel {
  AddTodoModel(this.ref);
  final ProviderRef ref;

  addTodo(BuildContext context, Map<String, dynamic>? formValues) {
    if (formValues != null) {
      ref.read(todoListProvider.notifier).addTodo(
            Todo(
              id: uuid.v4(),
              title: formValues['title'],
              startDate: formValues['startDate'],
              endDate: formValues['endDate'],
              completed: false,
            ),
          );
      context.pop();
    }
  }
}
