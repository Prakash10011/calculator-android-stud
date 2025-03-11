import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled1/main.dart';

void main() {
  testWidgets('Calculator initial display test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalculatorApp());

    // Verify that the initial display shows "0".
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('User can enter numbers', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Tap button "1"
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verify that display shows "1"
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Addition operation works', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Enter "2"
    await tester.tap(find.text('2'));
    await tester.pump();

    // Press "+"
    await tester.tap(find.text('+'));
    await tester.pump();

    // Enter "3"
    await tester.tap(find.text('3'));
    await tester.pump();

    // Press "="
    await tester.tap(find.text('='));
    await tester.pump();

    // Verify the result is "5"
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('Clear Entry (CE) button works', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Enter "7"
    await tester.tap(find.text('7'));
    await tester.pump();

    // Press "CE"
    await tester.tap(find.text('CE'));
    await tester.pump();

    // Verify the display is reset to "0"
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Clear (C) button resets everything', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Enter "8"
    await tester.tap(find.text('8'));
    await tester.pump();

    // Press "+"
    await tester.tap(find.text('+'));
    await tester.pump();

    // Press "C" to reset
    await tester.tap(find.text('C'));
    await tester.pump();

    // Verify everything is reset
    expect(find.text('0'), findsOneWidget);
    expect(find.text('+'), findsNothing);
  });
}
