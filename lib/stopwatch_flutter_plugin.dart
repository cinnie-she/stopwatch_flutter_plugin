import 'dart:async';

import 'package:flutter/services.dart';

import 'stopwatch_flutter_plugin_platform_interface.dart';

class StopwatchFlutterPlugin {
  // setup an event channel to listen from the native side
  // the name of the eventChannel should match that in the 'StopwatchFlutterPlugin.java' in the android side
  static const EventChannel _eventChannel = EventChannel('stopwatchStream');
  // Initialize a stream to receive broadcast stream from the eventChannel
  // Since receiveBroadcastStream returns Stream<dynamic>, we need to cast it back to dart type, 
  // which is int in this case indicating the time of the stopwatch
  final Stream<int> _stopwatchStream = _eventChannel.receiveBroadcastStream().map<int>((event) => event);

  // Future<String?> getPlatformVersion() {
  //   return StopwatchFlutterPluginPlatform.instance.getPlatformVersion();
  // }

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
  Stream<int> get stopwatchStream {   
    return _stopwatchStream;
  }
}
