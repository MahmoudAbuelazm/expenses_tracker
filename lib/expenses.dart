import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ExpensesList(expenses: expenses)],
      ),
    );
  }
}
