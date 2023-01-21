import 'dart:async';

import 'package:flutter/services.dart';

import 'stopwatch_flutter_plugin_platform_interface.dart';

class StopwatchFlutterPlugin {
  Future<bool?> startStopwatch() {
    return StopwatchFlutterPluginPlatform.instance.startStopwatch();
  }

  Future<bool?> stopStopwatch() {
    return StopwatchFlutterPluginPlatform.instance.stopStopwatch();
  }

  Future<bool?> resetStopwatch() {
    return StopwatchFlutterPluginPlatform.instance.resetStopwatch();
  }

  // Create a get method for the stream of stopwatch time values
  Stream<int>? get stopwatchStream {   
    return StopwatchFlutterPluginPlatform.instance.stopwatchStream;
  }
}
