// import 'package:sqflite/sqflite.dart';
// import 'package:student_records/db_helper/database_connection.dart';

// class Repository
// {
//   late DatabaseConnection _databaseConnection;

//   Repository(){
//     _databaseConnection=DatabaseConnection();
//   }
//   static Database? _database;
//   Future<Database?> get database async{
//     if(_database != null){
//       return _database;
//     }
//     else{
//       _database=await _databaseConnection.setDatabase();
//       return _database;
//     }
//   }
//   //insert
//   insertData(table,data) async{
//     var connection=await database;
//     return await connection?.insert(table, data);
//   }

//   //read all records
//   readData(table) async{
//     var connection=await database;
//     return await connection?.query(table);
//   }

//   //read a single record by id 
//   readDataById(table,userId)async{
//     var connection=await database;
//     return await connection?.query(table,where:'id=?',whereArgs: [userId]);
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