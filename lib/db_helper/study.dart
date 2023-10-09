// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseStudy{
//   static final DatabaseStudy _instance=DatabaseStudy();
//   static Database? _database;

//   factory DatabaseStudy() =>_instance;

//   DatabaseStudy._inst();

//   Future<Database> get database async{
//     if(_database!=null) return _database!;

//     _database=await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async{
//     final databasePath=await getDatabasesPath();
//     final path=join(databasePath,'employee_database.db');

//     return await openDatabase(
//       path,
//       version:1,
//       onCreate: _createDatabase,
//     );
//   }

//   Future<void> _createDatabase(Database db,int version) async{
//     await db.execute('''
//     CREATE TABLE employee(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         domain TEXT,
//         contact INTEGER,
//         imagePath TEXT 
//       )
//        '''
//     );
//   }

//   Future<int> insert(Map<String,dynamic>row) async {
//     final db = await database;
//     return await db.insert('student_table', row);
//   }




// }