import 'package:financial_tracker/services/transaction_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_new_transaction_page.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});
  
  List<Widget> getAllWidgetedTrxs(){
    List<DateTime> taken = [];
    List<Widget> trxs = [];
    Transaction? temp = getTransactionByIndex(0);
    int idx = 0;
    while(temp != null){
      if(!taken.contains(temp.date)){
        taken.add(temp.date);
      }
      idx++;
      temp = getTransactionByIndex(idx);
    }
    if(taken.isNotEmpty){
      taken.sort();
      for(int i = 0; i < taken.length; i++){
        trxs.add(datedTransactions(taken[i]));
      }
    }
    return trxs;
  }

  List<Widget> getWidgetedDated(DateTime date){
    List<Transaction> trxs = getTransactionByDate(date);
    // print('Transactions on $date: ${trxs.length}'); 
    List<Widget> widgetedTrxs = [];
    int i = 0;
    while(trxs.isNotEmpty && i < trxs.length){
      widgetedTrxs.add(transactionItem(trxs[i]));
      i++;
    }
    return widgetedTrxs;
  }

  int getTotalPerDate(String type, DateTime date){
    
    int total = 0;
    int i = 0;
    List<Transaction>? trxs = getTransactionByDate(date);
    print(date);
    while(trxs.isNotEmpty && i < trxs.length){
      if(trxs[i].type == type) total += trxs[i].amount;
      i++;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // addTransaction("Income", 520000, DateTime.now(), "Testing");
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Expanded(
            child:  ListView(
              children: 
                getAllWidgetedTrxs()
              
            ),
          ),
        ]
      ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewTransaction()),);
            }
        ),
     );
  }

  Widget datedTransactions(DateTime date){
    
    return Column(
      children: [
        Row(
        children: [
          Row(
            children: [
              Text(
                date.toString().split(" ")[0],
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  date.weekday.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children:  [
              SizedBox(width: 60,),
              Text(
                getTotalPerDate("Income", date).toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 30,),
              const SizedBox(width: 16),
              Text(
                getTotalPerDate("Expense", date).toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 8),
      // Transaction List
     SizedBox(
      height: 200,
      child: ListView(
        children: getWidgetedDated(date)
      ),
     ),
      ],
    );
  }

  Widget transactionItem(Transaction trx) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Text(trx.type, style: const TextStyle(fontSize: 24)),
              ),
              Text(
                trx.category,
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
          const Spacer(),
          Text(
            trx.amount.toString(),
            style: TextStyle(color: trx.type == "Expense" ? const Color.fromARGB(255, 255, 0, 0) : const Color.fromARGB(255, 0, 0, 255), fontSize: 16),
          ),
        ],
      ),
    );
  }
}