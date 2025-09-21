import 'package:flutter/material.dart';


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

  //vcariable to keep track of counter

  int _counter = 0;
  //increment method

  void _incrementCounter(){
    setState((){
      _counter ++;
    });
  }

  @override 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Colors.yellow,
        foregroundColor:  Colors.white,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'COunter Value:',
              style: TextStyle(
                fontSize:24,
                fontWeight:FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height:20),
            Text(//text that will display the coounter
              '$_counter',
              style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            //increment  butoon
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
              child:Text(
                'Increment',
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
