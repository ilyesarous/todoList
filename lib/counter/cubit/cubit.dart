import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit():super(CounterInitialState());
//to be easier when in use
  static CounterCubit get(context) => BlocProvider.of(context);  //objet mel class hetha bch nestaamlou dima

  int counter = 0;

  void minus(){
    counter--;
    emit(CounterMinusState(counter)); //tebaath lel state heki
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter));
  }
}