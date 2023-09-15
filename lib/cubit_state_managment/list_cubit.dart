import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/models/task.dart';

import '../db/db_helper.dart';
import 'list_state.dart';

class ListCubit extends Cubit<ListState>{

  ListCubit() : super(ListState(arrData: []));
  Future<void> addData({Task? task}) async {
    bool check= await NotesDatabase().addTask(task);
    if(check){
      emit(ListState(arrData:await NotesDatabase().fatchAllNote()));
    }
  }

  Future<void> initialData () async {
    emit(ListState(arrData:await NotesDatabase().fatchAllNote()));
  }

  Future<void> markTaskCompleted( Task task) async {
    await NotesDatabase().updateMark(task);
    emit(ListState(arrData: await NotesDatabase().fatchAllNote()));
  }

  Future<void> removeData(Task task) async {
     await NotesDatabase().deletNotes(task);
    emit(ListState(arrData: await NotesDatabase().fatchAllNote()));
  }



}