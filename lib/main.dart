import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  String operation = "";
  double? firstNum;
  bool isNewEntry = true;

  @override
  void initState() {
    super.initState();
    _loadLastValue();
  }

  void _loadLastValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      display = prefs.getString("lastValue") ?? "0";
    });
  }

  void _saveLastValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastValue", display);
  }

  void onNumberPress(String num) {
    setState(() {
      if (display.length < 8) {
        if (isNewEntry || display == "0") {
          display = num;
          isNewEntry = false;
        } else {
          display += num;
        }
      }
    });
  }

  void onOperationPress(String op) {
    setState(() {
      firstNum = double.tryParse(display);
      operation = op;
      isNewEntry = true;
    });
  }

  void onEqualsPress() {
    if (firstNum != null && operation.isNotEmpty) {
      double? secondNum = double.tryParse(display);
      double? result;

      if (secondNum == null) return;

      switch (operation) {
        case '+':
          result = firstNum! + secondNum;
          break;
        case '-':
          result = firstNum! - secondNum;
          break;
        case '*':
          result = firstNum! * secondNum;
          break;
        case '/':
          result = secondNum != 0 ? firstNum! / secondNum : double.nan;
          break;
      }

      setState(() {
        display = result != null && result.isFinite
            ? result.toStringAsFixed(2).replaceAll(RegExp(r"\.00$"), "")
            : "ERROR";
        _saveLastValue();
        isNewEntry = true;
        operation = "";
      });
    }
  }

  void onClearEntryPress() {
    setState(() {
      display = "0";
      isNewEntry = true;
    });
  }

  void onClearPress() {
    setState(() {
      display = "0";
      firstNum = null;
      operation = "";
      isNewEntry = true;
      _saveLastValue();
    });
  }

  Widget buildButton(String text, Function() onPress) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(display, style: const TextStyle(fontSize: 48)),
            ),
          ),
          Column(
            children: [
              for (var row in [
                ["1", "2", "3"],
                ["4", "5", "6"],
                ["7", "8", "9"],
                ["CE", "0", "C"]
              ])
                Row(
                  children: row.map((text) {
                    return buildButton(text, () {
                      if (text == "CE") {
                        onClearEntryPress();
                      } else if (text == "C") {
                        onClearPress();
                      } else {
                        onNumberPress(text);
                      }
                    });
                  }).toList(),
                ),
              Row(
                children: [
                  for (var op in ["+", "-", "*", "/", "="])
                    buildButton(op, () {
                      if (op == "=") {
                        onEqualsPress();
                      } else {
                        onOperationPress(op);
                      }
                    })
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
