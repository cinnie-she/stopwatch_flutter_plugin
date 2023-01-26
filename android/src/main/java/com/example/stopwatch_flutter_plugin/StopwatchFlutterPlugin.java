package com.example.stopwatch_flutter_plugin;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;

import android.os.Handler;

/** StopwatchFlutterPlugin */
public class StopwatchFlutterPlugin implements FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel & EventChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel methodChannel;
  private EventChannel eventChannel;

  // An EventSink is created here, which we'll later get its value from the event channel stream handler,
  // so that we can put data into the eventChannel which dart is listening for
  private EventChannel.EventSink mEventSink;

  // Initialization for the stopwatch
  Handler handler = new Handler();
  Runnable runnable;
  // The stopwatch time value which we are going to let the dart side listen for & update on the UI
  private int currentTime = 0;

  /// Register the methodChannel & eventChannel when this StopwatchFlutterPlugin has been associated with a FlutterEngine instance.
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    // The name should match the method channel name on dart side (in 'stopwatch_flutter_plugin.dart')
    methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "stopwatch_flutter_plugin");
    methodChannel.setMethodCallHandler(this);

    // The name should match the event channel name on dart side (in 'stopwatch_flutter_plugin.dart')
    eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "stopwatchStream"); 
    eventChannel.setStreamHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {    
    // when the method called is named 'startStopwatch', 
    if (call.method.equals("startStopwatch")) {
      // call the startStopwatch native function in this class 
      // & send a successful result back to flutter
      result.success(startStopwatch());
      // to handle an error result, can use result.error(String errorCode, String errorMessage, Object errorDetails)
      return;
    }

    // when the method called is named 'stopStopwatch', 
    if (call.method.equals("stopStopwatch")) {
      // call the stopStopwatch native function in this class 
      // & send a successful result back to flutter
      result.success(stopStopwatch());
      return;
    }

    // when the method called is named 'resetStopwatch', 
    if (call.method.equals("resetStopwatch")) {
      // call the resetStopwatch native function in this class 
      // & send a successful result back to flutter
      result.success(resetStopwatch());
      return;
    }

    // Handles a call to an unimplemented method.
    result.notImplemented();
  }

  /// The method runs a stopwatch function in a thread, which, the currentTime is incremented by 1 every second
  private boolean startStopwatch(){
    handler.postDelayed(runnable = new Runnable() {
      public void run() {
         handler.postDelayed(runnable, 1000); // delay by 1 second
         currentTime += 1; // increment current time by 1 second
         // put the updated stopwatch time into the event channel so that the dart side could obtain the value from the stream
         mEventSink.success(currentTime);
      }
   }, 1000);
   return true;
  }

  /// The method stops the stopwatch
  private boolean stopStopwatch(){
    handler.removeCallbacks(runnable);
    return true;
  }

  /// The method stops the stopwatch and reset the stopwatch current time to zero
  private boolean resetStopwatch(){
    handler.removeCallbacks(runnable);
    currentTime = 0;
    // Update the stopwatch time value to the dart side through the event channel
    mEventSink.success(currentTime);
    return true;
  }

  /// Unregister the methodChannel & eventChannel when this StopwatchFlutterPlugin has been associated with a FlutterEngine instance.
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // clean up methodChannel & eventChannel on detached
    methodChannel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
  }

  /// Override the onCancel method of the EventChannel.StreamHandler interface
  /// Handles a request to tear down the most recently created event stream.
  @Override
  public void onCancel(Object arguments) {
    mEventSink = null;
  }

  /// Override the onListen method of the EventChannel.StreamHandler interface
  /// Handles a request to set up an event stream.
  @Override
  public void onListen(Object arguments, EventChannel.EventSink events){
    // We get the event sink from the event channel handler, 
    // so later we can put data into the eventChannel which dart is listening for
    mEventSink = events;
  }
}
