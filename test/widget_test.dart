import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list_flutter/screens/home.dart';

void main() {
  testWidgets('Home screen should display a list of tasks', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(MaterialApp(home: Home()));

    // Find the task list widget.
    final taskListFinder = find.byType(ListView);

    // Check that the task list widget exists.
    expect(taskListFinder, findsOneWidget);
  });
}
