import 'package:amazing_todo/modules/add-edit-todo/model/add_todo_model.dart';
import 'package:amazing_todo/style/amazing_button_style.dart';
import 'package:amazing_todo/style/amazing_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/edit_todo_model.dart';

final autovalidateModeProvider =
    StateProvider.autoDispose((_) => AutovalidateMode.disabled);

class AddEditTodoPage extends ConsumerWidget {
  AddEditTodoPage({super.key, this.todoId});
  final String? todoId;

  final _formKey = GlobalKey<FormBuilderState>();

  bool get isEditMode => todoId != null;

  _buildFieldLabel(BuildContext context, String fieldLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        fieldLabel,
        style: Theme.of(context).textTheme.formFieldLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autovalidateMode = ref.watch(autovalidateModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit To-Do' : 'Add new To-Do'),
      ),
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        initialValue: ref.read(editTodoProvider(todoId)).initialValue,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel(context, 'To-Do Title'),
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(
                  hintText: 'Please key in your To-Do title here...',
                  border: OutlineInputBorder(),
                ),
                maxLength: 255,
                maxLines: 5,
                validator: FormBuilderValidators.required(),
              ),
              _buildFieldLabel(context, 'Start Date'),
              FormBuilderDateTimePicker(
                name: 'startDate',
                decoration: const InputDecoration(
                  hintText: 'Select a date',
                  border: OutlineInputBorder(),
                ),
                inputType: InputType.date,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                valueTransformer: (value) =>
                    value != null ? DateUtils.dateOnly(value) : null,
                validator: FormBuilderValidators.required(),
              ),
              _buildFieldLabel(context, 'Estimated End Date'),
              FormBuilderDateTimePicker(
                name: 'endDate',
                decoration: const InputDecoration(
                  hintText: 'Select a date',
                  border: OutlineInputBorder(),
                ),
                inputType: InputType.date,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now().add(const Duration(days: 1)),
                valueTransformer: (value) =>
                    value != null ? DateUtils.dateOnly(value) : null,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  (DateTime? value) {
                    DateTime? startDate =
                        _formKey.currentState?.fields['startDate']?.value;
                    if (value != null && startDate != null) {
                      if (startDate.isAfter(value) ||
                          startDate.isAtSameMomentAs(value)) {
                        return 'Please ensure end date is set after start date.';
                      }
                    }
                    return null;
                  }
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TextButton(
        style: Theme.of(context).textButtonTheme.bottomButton,
        child: Text(isEditMode ? 'Update' : 'Create Now'),
        onPressed: () {
          ref.read(autovalidateModeProvider.notifier).state =
              AutovalidateMode.always;

          if (_formKey.currentState?.saveAndValidate() ?? false) {
            if (isEditMode) {
              ref
                  .read(editTodoProvider(todoId))
                  .editTodo(context, _formKey.currentState?.value);
            } else {
              ref
                  .read(addTodoProvider)
                  .addTodo(context, _formKey.currentState?.value);
            }
          }
        },
      ),
    );
  }
}
