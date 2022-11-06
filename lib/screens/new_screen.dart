import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/components/components.dart';
import 'package:todo_list/shared/shared_cubit/cubit.dart';
import 'package:todo_list/shared/shared_cubit/states.dart';


class NewScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // return Container();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {} ,
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;

        return tasksBuilder(tasks: tasks);
      }
    );
  }
}
