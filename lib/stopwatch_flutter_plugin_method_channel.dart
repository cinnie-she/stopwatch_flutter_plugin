import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stopwatch_flutter_plugin_platform_interface.dart';

/// An implementation of [StopwatchFlutterPluginPlatform] that uses method channels.
class MethodChannelStopwatchFlutterPlugin extends StopwatchFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('stopwatch_flutter_plugin');

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
  //   return version;
  // }

  /// invoke the method named 'startTimer' in native code (i.e., Java)
  @override
  Future<bool?> startStopwatch() async {
    final status = await methodChannel.invokeMethod<bool>('startStopwatch');
    return status;
  }

  /// invoke the method named 'stopTimer' in native code (i.e., Java)
  @override
  Future<bool?> stopStopwatch() async {
    final status = await methodChannel.invokeMethod<bool>('stopStopwatch');
    return status;
  }

  /// invoke the method named 'resetTimer' in native code (i.e., Java)
  @override
  Future<bool?> resetStopwatch() async {
    final status = await methodChannel.invokeMethod<bool>('resetStopwatch');
    return status;
  }
}
