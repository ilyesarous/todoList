import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/counter/cubit/cubit.dart';
import 'package:todo_list/counter/cubit/states.dart';

class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // var s = BlocProvider.of(context); //methode bch nestad3i objects mel bloc

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if(state is CounterPlusState) {
            // print('plus state ${state.counter}');
          }
          if(state is CounterMinusState){
            // print('minus state');

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.blue,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        CounterCubit.get(context).plus();
                      }
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        CounterCubit.get(context).minus();
                      }
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
