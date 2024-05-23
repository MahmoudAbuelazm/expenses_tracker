import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      String? id})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;

  ExpenseBucket.forCategory(List<ExpenseModel> allexpenses,this.category)
      :expenses = allexpenses.where((expense) => expense.category == category).toList();

  ExpenseBucket({required this.category, required this.expenses});

  double get totalAmount {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}
