import 'package:flutter/material.dart';
import 'package:stopwatch_flutter_plugin/stopwatch_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // track if the stopwatch has started for styling the buttons
  bool _stopwatchIsStarted = false;
  // Get an instance of the plugin for accessing the native stopwatch
  final _stopwatchFlutterPlugin = StopwatchFlutterPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stopwatch plugin example app'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Receive the stopwatch stream from the plugin and build a text widget with the most recent time data
            StreamBuilder(
                stream: _stopwatchFlutterPlugin.stopwatchStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text('STOPWATCH STREAM: ${snapshot.data}');
                  } else {
                    return const Text('STOPWATCH STREAM: 0');
                  }
                }),
            // A sized box for creating some margin
            const SizedBox(width: 10, height: 20),
            // A button which starts the stopwatch through the plugin if it is not yet started
            ElevatedButton(
                onPressed: (_stopwatchIsStarted)
                    ? () => {}
                    : () async {
                        _stopwatchFlutterPlugin.startStopwatch();
                        // setState updates the UI
                        setState(() {
                          _stopwatchIsStarted = true;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (_stopwatchIsStarted) ? Colors.grey : Colors.blue,
                ),
                child: const Text("Start Stopwatch")),
            // A button which stops the stopwatch through the plugin
            ElevatedButton(
                onPressed: () async {
                  _stopwatchFlutterPlugin.stopStopwatch();
                  // setState updates the UI
                  setState(() {
                    _stopwatchIsStarted = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (_stopwatchIsStarted) ? Colors.blue : Colors.grey,
                ),
                child: const Text("Stop Stopwatch")),
            // A button which resets the stopwatch through the plugin
            ElevatedButton(
                onPressed: () async {
                  _stopwatchFlutterPlugin.resetStopwatch();
                  // setState updates the UI
                  setState(() {
                    _stopwatchIsStarted = false;
                  });
                },
                child: const Text("Reset Stopwatch")),
          ]),
        ),
      ),
    );
  }
}
