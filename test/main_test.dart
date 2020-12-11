import 'package:flutter_test/flutter_test.dart';
import 'package:home_control/MainTabWidget.dart';

import 'package:home_control/main.dart';

void main() {
  testWidgets('Test Main', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byType(MainTabs), findsOneWidget);

  });
}
