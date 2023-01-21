import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'stopwatch_flutter_plugin_method_channel.dart';

abstract class StopwatchFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a StopwatchFlutterPluginPlatform.
  StopwatchFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static StopwatchFlutterPluginPlatform _instance = MethodChannelStopwatchFlutterPlugin();

  /// The default instance of [StopwatchFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelStopwatchFlutterPlugin].
  static StopwatchFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StopwatchFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(StopwatchFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> startStopwatch() {
    throw UnimplementedError('startStopwatch() has not been implemented.');
  }

  Future<bool?> stopStopwatch() {
    throw UnimplementedError('stopStopwatch() has not been implemented.');
  }

  Future<bool?> resetStopwatch() {
    throw UnimplementedError('resetStopwatch() has not been implemented.');
  }

    Stream<int>? get stopwatchStream {  
    throw UnimplementedError('get stopwatchStream has not been implemented.');;
  }
}
