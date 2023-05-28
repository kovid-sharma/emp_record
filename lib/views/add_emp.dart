import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class AddEmp extends StatefulWidget {
  const AddEmp({Key? key}) : super(key: key);
//create api
  @override
  State<AddEmp> createState() => _AddEmpState();
}
TextEditingController _nameecontroller= TextEditingController();
TextEditingController _agecontroller= TextEditingController();
TextEditingController _salarycontroller= TextEditingController();
TextEditingController _idcontroller= TextEditingController();
class _AddEmpState extends State<AddEmp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      floatingActionButton: ClipOval(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: CircleBorder()
          ),


          onPressed: ()
          {
            //create api

            showDialog(
              context: context,
              builder: (BuildContext context) {

                return AlertDialog(
                  title: Text('Employee Update'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameecontroller,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _agecontroller,
                        decoration: InputDecoration(
                          labelText: 'Age',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _salarycontroller,
                        decoration: InputDecoration(
                          labelText: 'Salary',
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _idcontroller,
                        decoration: InputDecoration(
                          labelText: 'ID',
                        ),
                      ),

                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async{

                        //create
                        var url = Uri.parse('https://dummy.restapiexample.com/api/v1/create');

                        var body = jsonEncode({'name': _nameecontroller.text, 'salary': _salarycontroller.text,
                          'age': _agecontroller.text});

                        var response = await http.post(url, body: body);

                        if (response.statusCode == 201 || response.statusCode==200) {
                          // Request successful
                          var responseData = jsonDecode(response.body);
                          print('Data created successfully: $responseData');
                        } else {
                          // Request failed
                          print('Request failed with status: ${response.statusCode}');
                        }

                        Navigator.of(context).pop();

                      },
                      child: Text('Submit'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
