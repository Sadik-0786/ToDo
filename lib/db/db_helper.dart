
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class NotesDatabase {
 static final String _tableName='tasks';

  Future<Database> openDB() async {
    var myDirectory = await getApplicationDocumentsDirectory();
    await myDirectory.create(recursive: true);
    var dbPath = "$myDirectory/noteDB.db";
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $_tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT , date TEXT, startTime Text , endTime text , remind integer , repeat Text , color integer , isCompleted integer )");
    });
  }

  Future<bool> addTask(Task? task) async {
    var dbRef = await openDB();
    var check = await dbRef.insert( _tableName,task!.toJson());
    return check > 0;
  }

  Future<List<Task>> fatchAllNote() async {
    var dbRef = await openDB();
    List<Map<String, dynamic>> tasks = await dbRef.query(_tableName);
    List<Task> mTask = [];

    for(Map<String, dynamic> data in tasks){
      mTask.add(Task.fromJson(data));
    }
    return mTask;
  }

  Future<bool> updateMark(Task task) async {
    var dbRef = await openDB();
    var check = await dbRef.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''',[1,task.id]);
    return check > 0;
  }

  Future<void> deletNotes(Task task) async {
    var dbRef = await openDB();
    dbRef.delete(_tableName, where: 'id=?',whereArgs: [task.id]);
  }
}
