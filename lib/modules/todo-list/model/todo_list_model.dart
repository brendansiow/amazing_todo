import 'package:amazing_todo/modules/common/domain/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

final todoListSortedProvider = Provider<List<Todo>>((ref) {
  final todoList = ref.watch(todoListProvider);
  return todoList.where((todo) => !todo.completed).toList()
    ..sort((a, b) => a.endDate.compareTo(b.endDate));
});

final completedTodoListSortedProvider = Provider<List<Todo>>((ref) {
  final todoList = ref.watch(todoListProvider);
  return todoList.where((todo) => todo.completed).toList()
    ..sort((a, b) => b.endDate.compareTo(a.endDate));
});

final todoListProvider =
    StateNotifierProvider<TodoListModel, List<Todo>>((ref) {
  return TodoListModel(
    [
      //hardcoded todo for display purpose
      Todo(
        id: uuid.v4(),
        title: 'Do Leetcode',
        startDate: DateTime(2023, 3, 29),
        endDate: DateTime(2023, 3, 31),
        completed: false,
      ),
      Todo(
        id: uuid.v4(),
        title: 'Buy Milk',
        startDate: DateTime(2023, 3, 16),
        endDate: DateTime(2023, 3, 17),
        completed: true,
      ),
      Todo(
        id: uuid.v4(),
        title: 'Do Housechores',
        startDate: DateTime(2023, 3, 15),
        endDate: DateTime(2023, 3, 16),
        completed: true,
      ),
    ],
  );
});

class TodoListModel extends StateNotifier<List<Todo>> {
  TodoListModel(super.state);

  addTodo(Todo todo) {
    state = [...state, todo];
  }

  editTodo(String id, Todo todo) {
    state = state.map((e) {
      if (e.id == id) {
        return todo;
      }
      return e;
    }).toList();
  }

  onChecked(String id, bool value) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: value) else todo,
    ];
  }
}
