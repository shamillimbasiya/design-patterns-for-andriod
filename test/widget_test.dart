import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/password_strength_meter.dart';

void main() {
  testWidgets('PasswordStrengthMeter renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PasswordStrengthMeter(
            password: 'MySecurePassword123!',
          ),
        ),
      ),
    );

    expect(find.text('Password Strength:'), findsOneWidget);
  });

  testWidgets('PasswordStrengthMeter uses custom strength calculation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PasswordStrengthMeter(
            password: 'CustomStrength123!',
          ),
        ),
      ),
    );

    expect(find.text('Very Strong'), findsOneWidget);
  });

  testWidgets('PasswordStrengthMeter displays correct color and strength level',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PasswordStrengthMeter(
            password: 'Secure123!',
          ),
        ),
      ),
    );

    Color expectedColor = Colors.lightGreen;

    final Finder strengthIndicatorFinder = find.byType(Container);

    final Color? actualColor =
        tester.widget<Container>(strengthIndicatorFinder).color;

    expect(actualColor, equals(expectedColor));
  });
}
