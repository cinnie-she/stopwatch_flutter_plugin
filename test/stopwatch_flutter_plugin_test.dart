import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch_flutter_plugin/stopwatch_flutter_plugin.dart';
import 'package:stopwatch_flutter_plugin/stopwatch_flutter_plugin_platform_interface.dart';
import 'package:stopwatch_flutter_plugin/stopwatch_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStopwatchFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements StopwatchFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StopwatchFlutterPluginPlatform initialPlatform = StopwatchFlutterPluginPlatform.instance;

  test('$MethodChannelStopwatchFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStopwatchFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    StopwatchFlutterPlugin stopwatchFlutterPlugin = StopwatchFlutterPlugin();
    MockStopwatchFlutterPluginPlatform fakePlatform = MockStopwatchFlutterPluginPlatform();
    StopwatchFlutterPluginPlatform.instance = fakePlatform;

    expect(await stopwatchFlutterPlugin.getPlatformVersion(), '42');
  });
}
