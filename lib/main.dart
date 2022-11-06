import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/counter/counter.dart';
import 'package:todo_list/home_screen/home_screen.dart';
import 'package:todo_list/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver(); //kel historique aala kol haja aamltha bin les states
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeScreen(),
     // home: Counter(),
   );
  }
}
