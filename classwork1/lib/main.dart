import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch:Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterScreen extends StatefulWidget{
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>{

  //variable to keep track of counter
  int _counter = 0;

  @override
  void initState(){
    super.initState();
    _loadCounter(); //Load saved counter value on app launch
  }

  //load counter value from SharedPreferences
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      _counter = (prefs.getInt('counter') ?? 0);
    });
    print('Counter loaded: $_counter'); // Debug print
  }

  //save counter value to SharedPreferences
  _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
    print('Counter saved: $_counter'); // Debug print
  }

  //increment method
  void _incrementCounter(){
    setState((){
      _counter++;
    });
    _saveCounter(); //save state after incrementing
  }

  // Reset method with confirmation dialog
  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Counter'),
          content: Text('Are you sure you want to reset the counter to 0? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _resetCounter(); // Reset the counter
              },
            ),
          ],
        );
      },
    );
  }

  // Reset counter to 0
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _saveCounter(); // Save the reset state
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.white,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Value:', // Fixed typo
              style: TextStyle(
                fontSize:24,
                fontWeight:FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height:20),
            Text(//text that will display the counter
              '$_counter',
              style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reset button
                ElevatedButton(
                  onPressed: _showResetDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Increment button
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Increment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}