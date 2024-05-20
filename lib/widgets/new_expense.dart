import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(ExpenseModel) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category? selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.parse(amountController.text);
    final amountIsInValid = enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInValid ||
        selectedDate == null ||
        selectedCategory == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Inavlid Input'),
                content: const Text(
                    'Please make sure a valid title , amount ,date and category is entered.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.addExpense(ExpenseModel(
        title: titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                prefixText: '\$',
                label: Text('Title'),
              ),
            ),
          ),
          Row(
            children: [
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(selectedDate!)),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
