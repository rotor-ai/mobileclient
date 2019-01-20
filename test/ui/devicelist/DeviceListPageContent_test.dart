
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileclient/RotorStrings.dart';
import 'package:mobileclient/ui/devicelist/DeviceListPageContent.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Should show bluetooth warning when not available', (WidgetTester tester) async {

    //ARRANGE
    var mockFlutterBlue = MockFlutterBlue();
    when(mockFlutterBlue.isAvailable).thenAnswer((_) => new Future.value(false));
    final btWarningFinder = find.text(RotorStrings.UI_BT_NOT_AVAILABLE);

    //ACT
    var deviceListPageContent = DeviceListPageContent(mockFlutterBlue);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: deviceListPageContent,)));
    await tester.pumpAndSettle();

    //ASSERT
    expect(btWarningFinder, findsOneWidget);
  });
}

//========== Mock definitions ==========

class MockFlutterBlue extends Mock implements FlutterBlue {}