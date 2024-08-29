import 'package:financial_tracker/services/transaction_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewTransaction extends StatelessWidget{
  const CreateNewTransaction({super.key});


  @override
  Widget build(BuildContext context) {
    return _NewTransactionForm();
  }
}

class _NewTransactionForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewTransactionFormState();
  }
}

List<String> trTypeOptions = ['Income', 'Expense'];

class _NewTransactionFormState extends State<_NewTransactionForm>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  DateTime? _pickedDate = DateTime.now();
  List<bool> _selectedButtons = List.generate(2, (_) => false);


  Future<void> _selectDate() async {
    _pickedDate = await showDatePicker(
      context: context,
      initialDate: _pickedDate as DateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if(_pickedDate != null){
      setState(() {
        _dateController.text = _pickedDate.toString().split(" ")[0];
      });
    }else{
      setState(() {
        _pickedDate = DateTime.now();
        _dateController.text = _pickedDate.toString().split(" ")[0];
      });
    }
  }

  int transactionAmount = 0;
  String transactionCategory = '';
  String transactionType = trTypeOptions[0];

  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
          child: Column(
            children: <Widget>[
              RadioListTile(
                title: const Text('Income'),
                value: trTypeOptions[0],
                groupValue: transactionType,
                onChanged: (value){
                  setState(() {
                    transactionType = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text('Expense'),
                value: trTypeOptions[1],
                groupValue: transactionType,
                onChanged: (value){
                  setState(() {
                    transactionType = value.toString();
                  });
                },
              ),
              TextFormField(
                
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
              TextFormField(
                onSaved: (value) {transactionAmount = int.parse(value as String);},
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter Amount!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    )
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextFormField(
                onSaved: (value) {transactionCategory = value as String;},
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter Category!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    )
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    debugPrint('type: $transactionType, amount: $transactionAmount, date: $_pickedDate, category: $transactionCategory');
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      setState(() {
                        addTransaction(transactionType, transactionAmount, _pickedDate as DateTime, transactionCategory);
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Added")));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Transaction'),
              )
            ],
          )
        ),
      )
    );
  }
}