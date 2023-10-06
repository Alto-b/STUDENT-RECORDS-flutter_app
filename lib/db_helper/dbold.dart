// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseConnection
// {
//   static Database? _database;
//   Future<Database?> setDatabase() async
// {
//   if(_database != null){
//       return _database;
//     }
// else{
//   var directory=await getApplicationDocumentsDirectory();
//   var path=join(directory.path,'db_students');
//   var database = await openDatabase(path,version:1,onCreate:_createDatabase);
// return database;
// }
// }
// Future<void> _createDatabase(Database database,int version) async{
//   String sql="CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,domain TEXT,contact INT)";
//   await database.execute(sql);
// }
//  //insert
//   insertData(table,data) async{
//     final db= _database;
//     return await db?.insert(table, data);
//   }

//   //read all records
//   readData(table) async{
//    final db= _database;
//     return await db?.query(table);
//   }

//   //read a single record by id 
//   readDataById(table,userId)async{
//  final db = _database;
//     return await db?.query(table,where:'id=?',whereArgs: [userId]);
//   }

//   //update student
//    updateData(table,data) async{
//     var connection=await database;
//     return await connection?.update(table,data,where: 'id=?',whereArgs: [data['id']]);
//    }

//    //delete student
//    deleteDataById(table,userId) async{
//     var connection=await database;
//     return await connection?.rawDelete("delete from $table where id=$userId");
//    }

 
// }