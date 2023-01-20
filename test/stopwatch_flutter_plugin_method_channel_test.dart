import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch_flutter_plugin/stopwatch_flutter_plugin_method_channel.dart';

void main() {
  MethodChannelStopwatchFlutterPlugin platform = MethodChannelStopwatchFlutterPlugin();
  const MethodChannel channel = MethodChannel('stopwatch_flutter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
