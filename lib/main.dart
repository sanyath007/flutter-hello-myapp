import 'package:flutter/material.dart';
// import 'package:flutter_hello_app/pass_data.dart';
// import 'package:flutter_hello_app/fetch_data.dart';
import 'package:flutter_hello_app/bg_parsing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          primaryColor: Colors.white,
      ),
      // home: RandomWords(),
      // home: MyScaffold(),
      // home: TodosScreen(
      //   todos: List.generate(
      //     20, 
      //     (i) => Todo(
      //       'Todo $i',
      //       'A description of what needs to be done for Todo $i',
      //     ),
      //   ),
      // ),
      // home: FetchData(),
      home: BgParsing(title: 'Isolate Demo'),
    );
  }
}