import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/layouts/main_layout/cubit/main_states.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);

  initSql() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE goals
    ((id INTEGER PRIMARY KEY, 
    title TEXT)''');
      },
    );
  }

  List<Map> goalsList = [];
  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);

    await database
        .rawQuery('SELECT * FROM goals')
        .then((value) {
          goalsList = value;
          emit(GetDataSuccessState());
        })
        .catchError((onError) {
          emit(GetDataErrorState());
          print(onError.toString());
        });

    database.close();
  }

  insertData(String name) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);

    await database
        .rawInsert('INSERT INTO goals (name) VALUES (?)', [name])
        .then((value) {
          emit(InsertDataSuccessState());
        })
        .catchError((onError) {
          emit(InsertDataErrorState());
          print(onError.toString());
          
        });
  }
}
