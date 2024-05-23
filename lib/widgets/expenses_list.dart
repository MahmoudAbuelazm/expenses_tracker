import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expense_card.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.deleteExpense});
  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel) deleteExpense;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(.75),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onDismissed: (direction) {
              deleteExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseCard(expense: expenses[index])),
      ),
    );
  }
}
