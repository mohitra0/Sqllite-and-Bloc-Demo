import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class InitTodoState extends TodoState {
  final int counter;

  const InitTodoState(this.counter);

  @override
  List<Object> get props => [counter];
}

class AddProductState extends TodoState {}

class RemoveProductState extends TodoState {}
