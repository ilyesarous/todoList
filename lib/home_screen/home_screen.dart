
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/components/components.dart';
import 'package:todo_list/const/const.dart';
import 'package:todo_list/screens/archive_screen.dart';
import 'package:todo_list/screens/done_screen.dart';
import 'package:todo_list/screens/new_screen.dart';
import 'package:todo_list/shared/shared_cubit/cubit.dart';
import 'package:todo_list/shared/shared_cubit/states.dart';

class HomeScreen extends StatelessWidget {

  // List screens = [
  //   NewScreen(),
  //   DoneScreen(),
  //   ArchiveScreen(),
  // ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  // IconData icon = Icons.edit;
  // bool isBottomSheetShown = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  // late Database database;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createBD(), // kinaaml .. 9oul aaliya rajaatou variable
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Todo',
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertDB(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    ).then((value) {
                      Navigator.pop(context);
                      titleController.text = '';
                      timeController.text = '';
                      dateController.text = '';
                      cubit.isBottomSheetShown = false;
                      // setState(() {
                      //   icon = Icons.edit;
                      // });
                    });
                  }
                }
                else{
                  scaffoldKey.currentState?.showBottomSheet((context) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultInput(
                            title: 'Task Title',
                            preIcon: Icons.title,
                            textController: titleController,
                            type: TextInputType.text,
                            validate: (value) {
                              if(value.isEmpty){
                                return 'Title required!';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultInput(
                              title: 'Task Time',
                              preIcon: Icons.watch_later_outlined,
                              textController: timeController,
                              type: TextInputType.datetime,
                              validate: (value) {
                                if(value.isEmpty){
                                  return 'Time required!';
                                }
                              },
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text = value!.format(context).toString();
                                });
                              }
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultInput(
                              title: 'Task Date',
                              preIcon: Icons.calendar_month,
                              textController: dateController,
                              type: TextInputType.datetime,
                              validate: (value) {
                                if(value.isEmpty){
                                  return 'Date required!';
                                }
                              },
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2026-12-30'),
                                ).then((value) {
                                  dateController.text = DateFormat.yMMMd().format(value!);
                                });
                              }
                          ),
                        ],
                      ),
                    ),
                  ) ,
                      elevation: 50).closed.then((value) {
                    cubit.changeBottomSheetState(
                        isBottomSheetShown: false,
                        icon: Icons.edit,
                    );
                    // isBottomSheetShown = false;
                    // setState(() {
                    //   icon = Icons.edit;
                    // });
                  });
                  cubit.changeBottomSheetState(
                      isBottomSheetShown: true,
                      icon: Icons.add,
                  );
                  // setState(() {
                  //   isBottomSheetShown = true;
                  //   icon = Icons.add;
                  // });
                }
              },
              child: Icon(
                cubit.icon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                  ),
                  label: 'Archive',
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index){
                // setState(() {
                //   currentIndex = index;
                // });
                cubit.changeIndex(index);
              },
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
  // void createBD() async {
  //   database = await openDatabase(
  //       'todo.db',
  //       version: 1,
  //       onCreate: (database, version) async {
  //         // When creating the db, create the table
  //         await database.execute(
  //             'CREATE TABLE Tasks ('
  //                 'id INTEGER PRIMARY KEY,'
  //                 'title TEXT,'
  //                 'time TEXT,'
  //                 'date TEXT,'
  //                 'status TEXT)').then((value) {
  //                   print('DATABASE created');
  //         });
  //       },
  //       onOpen: (database) {
  //         getDataBase(database).then((value){
  //           tasks = value;
  //           print(tasks);
  //         });
  //         print('database opened');
  //       }
  //   );
  // }
  //
  // Future insertDB({
  //   required String title,
  //   required String time,
  //   required String date,
  // }) async {
  //   return database.transaction((txn) async {
  //     await txn.rawInsert('INSERT INTO Tasks(title, time, date, status) '
  //         'VALUES ("$title", "$time", "$date", "new")',
  //     ).then((value){
  //       print('$value inserted successfuly');
  //     }).catchError((error){
  //       print('error while inserting ${error.toString()}');
  //     });
  //   });
  // }
  //
  // Future<List<Map>> getDataBase(database) async{
  //   return await database.rawQuery('select * from Tasks');
  // }
}
