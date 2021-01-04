import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String transactionTABLE = "transactionTABLE";
final String idColumn = "idColumn";
final String dateColumn = "dateColumn";
final String valueColumn = "valueColumn";
final String typeColumn = "typeColumn";
final String descriptionColumn = "descriptionColumn";


class TransactionHelper{

  static final TransactionHelper _instance = TransactionHelper.internal();

  factory TransactionHelper() => _instance;

  TransactionHelper.internal();

  Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "transaction.db");

    return await openDatabase(path,version: 1,onCreate: (Database db,int newerVersion)async{
      await db.execute(
          "CREATE TABLE $transactionTABLE(" +
              "$idColumn INTEGER PRIMARY KEY,"+
              "$valueColumn FLOAT,"+
              "$dateColumn TEXT,"+
              "$typeColumn TEXT,"+
              "$descriptionColumn TEXT)"
      );
    });
  }

  Future<Transaction> savetransaction(Transaction transaction)async{
    print("Data added");
    Database dbTransaction = await db;
    transaction.id = await dbTransaction.insert(transactionTABLE, transaction.toMap());
    return transaction;
  }

  Future<Transaction> getTransaction(int id)async{
    Database dbTransaction = await db;
    List<Map> maps = await dbTransaction.query(transactionTABLE,
        columns: [idColumn,valueColumn, dateColumn, typeColumn,descriptionColumn],
        where: "$idColumn =?",
        whereArgs: [id]);

    if(maps.length > 0){
      return Transaction.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deletetransaction(Transaction transaction)async{
    Database dbTransaction = await db;
    return await dbTransaction.delete(transactionTABLE,
        where: "$idColumn =?",
        whereArgs: [transaction.id]);
  }

  Future<int> updatetransaction(Transaction transaction)async{
    print("Data updated");
    print(transaction.toString());
    Database dbTransaction = await db;
    return await dbTransaction.update(transactionTABLE,transaction.toMap(),
        where: "$idColumn =?",
        whereArgs: [transaction.id]
    );
  }

  Future<List> getAllTransaction()async{
    Database dbTransaction = await db;
    List listMap = await dbTransaction.rawQuery("SELECT * FROM $transactionTABLE");
    List<Transaction> listTransaction = List();

    for(Map m in listMap){
      listTransaction.add(Transaction.fromMap(m));
    }
    return listTransaction;
  }
  Future<List> getAllTransactionByMonth(String data)async{
    Database dbTransaction = await db;
    List listMap = await dbTransaction.rawQuery("SELECT * FROM $transactionTABLE WHERE $dateColumn LIKE '%$data%'");
    List<Transaction> listTransaction = List();

    for(Map m in listMap){
      listTransaction.add(Transaction.fromMap(m));
    }
    return listTransaction;
  }

  Future<List> getAllTransactionByType(String type)async{
    Database dbTransaction = await db;
    List listMap = await dbTransaction.rawQuery("SELECT * FROM $transactionTABLE WHERE $typeColumn ='$type' ");
    List<Transaction> listTransaction = List();

    for(Map m in listMap){
      listTransaction.add(Transaction.fromMap(m));
    }
    return listTransaction;
  }

  Future<int> getNumber()async{
    Database dbTransaction = await db;
    return Sqflite.firstIntValue(await dbTransaction.rawQuery(
        "SELECT COUNT(*) FROM $transactionTABLE"));
  }

  Future close()async{
    Database dbTransaction = await db;
    dbTransaction.close();
  }
}



class Transaction{

  int id;
  String date;
  double value;
  String type;
  String description;

  Transaction();

  Transaction.fromMap(Map map){
    id = map[idColumn];
    value = map[valueColumn];
    date = map[dateColumn];
    type = map[typeColumn];
    description = map[descriptionColumn];

  }


  Map toMap(){
    Map<String,dynamic> map ={
      valueColumn :value,
      dateColumn : date,
      typeColumn : type,
      descriptionColumn : description,

    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  String toString(){
    return "Transaction(id: $id, value: $value, data: $date, type: $type, desc: $description, )";
  }
}