import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'stopwatch_flutter_plugin_platform_interface.dart';

/// An implementation of [StopwatchFlutterPluginPlatform] that uses method channels.
class MethodChannelStopwatchFlutterPlugin extends StopwatchFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('stopwatch_flutter_plugin');

  // setup an event channel to listen from the native side
  // the name of the eventChannel should match that in the 'StopwatchFlutterPlugin.java' in the android side
  @visibleForTesting
  final _eventChannel = const EventChannel('stopwatchStream');

  // Initialize a stream to receive broadcast stream from the eventChannel
  // Since receiveBroadcastStream returns Stream<dynamic>, we need to cast it back to dart type, 
  // which is int in this case indicating the time of the stopwatch
  Stream<int>? _stopwatchStream;

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

  // Create a get method for the stream of stopwatch time values
  @override
  Stream<int>? get stopwatchStream {  
    // if the current stream is null, then receive the broadcast stream from the eventChannel
    _stopwatchStream ??= _eventChannel.receiveBroadcastStream().map<int>((event) => event);
    return _stopwatchStream;
  }
}
