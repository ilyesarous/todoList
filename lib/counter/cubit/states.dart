abstract class CounterStates {}

class CounterInitialState extends CounterStates{}

class CounterPlusState extends CounterStates{
  final int counter;

  CounterPlusState(this.counter);
}
class CounterMinusState extends CounterStates{
  final int counter;  //hetha itha nheb nebaath data fl state

  CounterMinusState(this.counter);
}