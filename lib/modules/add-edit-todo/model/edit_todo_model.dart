import 'package:amazing_todo/modules/common/domain/todo.dart';
import 'package:amazing_todo/modules/todo-list/model/todo_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

final editTodoProvider = Provider.family<EditTodoModel, String?>(
    (ref, todoId) => EditTodoModel(ref, todoId));

class EditTodoModel {
  EditTodoModel(this.ref, this.todoId);
  final ProviderRef ref;
  final String? todoId;

  Todo? get todo =>
      ref.read(todoListProvider).firstWhereOrNull((e) => e.id == todoId);

  Map<String, dynamic> get initialValue {
    if (todo != null) {
      return {
        'title': todo!.title,
        'startDate': todo!.startDate,
        'endDate': todo!.endDate,
        'completed': todo!.completed
      };
    }
    return {};
  }

  editTodo(BuildContext context, Map<String, dynamic>? formValues) {
    if (todo != null && formValues != null) {
      ref.read(todoListProvider.notifier).editTodo(
          todo!.id,
          todo?.copyWith(
            title: formValues['title'],
            startDate: formValues['startDate'],
            endDate: formValues['endDate'],
            completed: todo!.completed,
          ));
      context.pop();
    }
  }
}
