import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/shared/shared_cubit/states.dart';
import '../../screens/archive_screen.dart';
import '../../screens/done_screen.dart';
import '../../screens/new_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  IconData icon = Icons.edit;
  bool isBottomSheetShown = false;
  List newTasks = [];
  List doneTasks = [];
  List archivedTasks = [];
  late Database database;
  int currentIndex = 0;
  List<Widget> screens = [
    NewScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  void changeBottomSheetState({
    required bool isBottomSheetShown,
    required IconData icon
  }){
    this.isBottomSheetShown = isBottomSheetShown;
    this.icon = icon;
    emit(AppChangeBottomSheetState());
  }
  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createBD() {
      openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          // When creating the db, create the table
            database.execute(
              'CREATE TABLE Tasks ('
                  'id INTEGER PRIMARY KEY,'
                  'title TEXT,'
                  'time TEXT,'
                  'date TEXT,'
                  'status TEXT)').then((value) {
                    print('DATABASE created');
          });
        },
        onOpen: (database) {
          getDataBase(database);
          print('database opened');
        }
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
      });
  }

  insertDB({
    required String title,
    required String time,
    required String date,
  }) async{
    await database.transaction((txn) async{
      txn.rawInsert('INSERT INTO Tasks(title, time, date, status) '
          'VALUES ("$title", "$time", "$date", "new")',
      ).then((value){
        print('$value inserted successfuly');
        emit(AppInsertDBState());
        getDataBase(database);
      }).catchError((error){
        print('error while inserting ${error.toString()}');
      });
      return null;
    });

  }

  void getDataBase(database){

    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDBLoadingState());
    database.rawQuery('select * from Tasks').then((value){
      value.forEach((element) {
        if(element['status'] == 'new'){
          newTasks.add(element);
        }else if(element['status'] == 'done'){
          doneTasks.add(element);
        }else{
            archivedTasks.add(element);
        }
      });

      emit(AppGetDBState());
    });
  }

  void updateDatabase({
  required String status,
    required int id,
}) async{
     database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value){
          getDataBase(database);
          emit(AppUpdateDataBaseState());
     });
  }
  void deleteData({
  required int id,
})async{
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]);
    getDataBase(database);
    emit(AppDeleteDataBaseState());
  }
}