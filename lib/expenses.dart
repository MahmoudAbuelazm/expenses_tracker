import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';
import 'widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> expenses = [
    ExpenseModel(
        title: 'Flutter',
        amount: 100.0,
        date: DateTime.now(),
        category: Category.food),
    ExpenseModel(
        title: 'Dart',
        amount: 200.0,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('Flutter Expenses Tracker'),
      ),
      body: Column(
        children: [ExpensesList(expenses: expenses)],
      ),
    );
  }
}
