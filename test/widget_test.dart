import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vijolicen_to_do/main.dart';

void main() {
  testWidgets('Verify task list appears', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial tasks are displayed.
    expect(find.text('naloga 1'), findsOneWidget);
    expect(find.text('naloga 2'), findsOneWidget);
    expect(find.text('naloga 3'), findsOneWidget);
    expect(find.text('naloga 4'), findsOneWidget);

    // Verify that an unrelated task is not displayed.
    expect(find.text('naloga 5'), findsNothing);
  });
}
