// Urban Wildlife Tracker app tests
//
// Tests for the Urban Wildlife Tracker application functionality.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:urban_wildlife_tracker/main_simple.dart';

void main() {
  testWidgets('Urban Wildlife Tracker app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify that the app title is displayed.
    expect(find.text('Urban Wildlife Tracker'), findsOneWidget);
    
    // Verify that the floating action button is present.
    expect(find.byIcon(Icons.add), findsOneWidget);
    
    // Verify that refresh button exists.
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
