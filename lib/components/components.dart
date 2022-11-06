import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/shared/shared_cubit/cubit.dart';

Widget defaultInput ({

  required String title,
  required IconData preIcon,
  required TextEditingController textController,
  required TextInputType type,
  var validate,
  var sufIcon,
  var sufIconPressed,
  bool obscure = false,
  var onTap,

}) => TextFormField(
  decoration: InputDecoration(
    label: Text(
        title,
    ),
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      preIcon,
    ),
  suffixIcon: MaterialButton(
      onPressed: (){
        sufIconPressed;
      },
      child: Icon(
        sufIcon,
      )
  )
  ),
  obscureText: obscure,
  keyboardType: type,
  onTap: onTap,
  controller: textController,
  validator: validate,
);

Widget defaultTaskDesign(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35,
          child: Text(
            model['time'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               model['title'],
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model['date'],
                style: TextStyle(color: Colors.grey[600],

                ),
              ),

            ],

          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateDatabase(status: 'done', id: model['id']);
            },
            icon: Icon(
                Icons.check_box,
              color: Colors.green,
            ),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateDatabase(status: 'archive', id: model['id']);
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List tasks,
}) => ConditionalBuilder(
condition: tasks.length > 0,
builder: (context) => ListView.separated(
itemBuilder: (context, index) => defaultTaskDesign(tasks[index], context),
separatorBuilder: (context, index) => Padding(
padding: const EdgeInsets.symmetric(
horizontal: 20
),
child: Container(
width: double.infinity,
height: 1,
color: Colors.grey[300],
),
),
itemCount: tasks.length,
),
fallback: (context) => Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.menu,
size: 100,
color: Colors.grey,
),
Text(
'No Tasks Yet! Please Add Some Tasks',
style: TextStyle(
fontSize: 16,
color: Colors.grey,
fontWeight: FontWeight.bold
),
),
],
),
),
);