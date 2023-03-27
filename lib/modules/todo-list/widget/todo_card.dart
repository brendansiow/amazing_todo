import 'package:amazing_todo/modules/common/domain/todo.dart';
import 'package:amazing_todo/style/amazing_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
    required this.onChecked,
  });
  final Todo todo;
  final VoidCallback? onTap;
  final ValueChanged<bool> onChecked;

  _getTimeLeft() {
    Duration timeLeft = Duration(
        milliseconds: todo.endDate.millisecondsSinceEpoch -
            DateTime.now().millisecondsSinceEpoch);
    if (timeLeft.inMilliseconds.isNegative) {
      return 'Exceeded';
    }
    if (timeLeft.inHours > 24) {
      return '${timeLeft.inDays} days ${timeLeft.inHours.remainder(24)} hrs ${timeLeft.inMinutes.remainder(60)} min';
    }
    return '${timeLeft.inHours} hrs ${timeLeft.inMinutes.remainder(60)} min';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: Theme.of(context).textTheme.cardTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      VerticalLabelValue(
                        label: 'Start Date',
                        value: DateFormat('d MMMM yyyy').format(todo.startDate),
                      ),
                      const SizedBox(width: 10),
                      VerticalLabelValue(
                        label: 'End Date',
                        value: DateFormat('d MMMM yyyy').format(todo.endDate),
                      ),
                      const SizedBox(width: 10),
                      VerticalLabelValue(
                        label: 'Time Left',
                        value: _getTimeLeft(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFFE7E3D0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Status'),
                      const SizedBox(width: 10),
                      Text(
                        todo.completed ? 'Completed' : 'Incomplete',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Tick if completed'),
                      Checkbox(
                        value: todo.completed,
                        onChanged: (bool? value) => onChecked(value ?? false),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VerticalLabelValue extends StatelessWidget {
  const VerticalLabelValue(
      {super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
