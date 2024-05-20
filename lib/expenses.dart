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
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              addExpense: _addExpense,
            ));
  }

  void _deleteExpense(ExpenseModel expense) {
    final index = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Expense deleted successfully!'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                expenses.insert(index, expense);
              });
            },
          )),
    );
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      expenses.add(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expense added successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (expenses.isNotEmpty) {
      mainWidget =
          ExpensesList(expenses: expenses, deleteExpense: _deleteExpense);
    }
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
        children: [mainWidget],
      ),
    );
  }
}
