import 'package:flutter/cupertino.dart';

List<Transaction> transactions = [];

void addTransaction(String type, int amount, DateTime date, String category){
  Transaction newTrx = Transaction(type, amount, date, category);
  transactions.add(newTrx);
}

List<Transaction> getTransactions(){
  return transactions;
}

Transaction? getTransactionByIndex(int idx){
  return transactions.isNotEmpty && transactions.length > idx? transactions[idx] : null;
}

List<Transaction> getTransactionByDate(DateTime date){
  List<Transaction> trxs = [];
  int i = 0;
  while ( i < transactions.length){
    print(trxs.length);
    if(date.day == transactions[i].date.day && date.month == transactions[i].date.month && date.year == transactions[i].date.year){
       trxs.add(transactions[i]);
    }
    i++;
  }
  return trxs;
}

void updateTransaction(int idx, String type, int amount, DateTime date, String category){
  Transaction trx = transactions[idx];
  trx.type = type;
  trx.amount = amount;
  trx.date = date;
  trx.category = category;
}

void deleteTransaction(int idx){
  transactions.isNotEmpty && transactions.length > idx ? transactions.remove(transactions[idx]) : idx = idx;
  
}

class Transaction {
  String type;
  int amount;
  DateTime date;
  String category;

  Transaction(this.type, this.amount, this.date, this.category);
}