import 'package:expense_tracker/widgets/chart.dart';
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
        useSafeArea: true,
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
    double width = MediaQuery.of(context).size.width;
    Widget mainWidget = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (expenses.isNotEmpty) {
      mainWidget =
          ExpensesList(expenses: expenses, deleteExpense: _deleteExpense);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('Flutter Expenses Tracker'),
      ),
      body: width > 600
          ? Row(
              children: [
                Expanded(child: Chart(expenses: expenses)),
                Expanded(child: mainWidget),
              ],
            )
          : Column(
              children: [
                Chart(expenses: expenses),
                Expanded(child: mainWidget)
              ],
            ),
    );
  }
}
