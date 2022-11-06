import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';
import '../shared/shared_cubit/cubit.dart';
import '../shared/shared_cubit/states.dart';

class ArchiveScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          var tasks = AppCubit.get(context).archivedTasks;

          return tasksBuilder(tasks: tasks);
        }
    );
  }
}
