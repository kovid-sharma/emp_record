import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../api/api.dart';
import '../model/dialog.dart';
import '../model/employee.dart';
import '../model/response.dart';
import '../providers/listview_provider.dart';
import 'add_emp.dart';

final List<Employee> emps=[];
TextEditingController _nameController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _salaryController = TextEditingController();
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> fetchData() async {
    final response = await http.get(
        Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the API function when the app initializes
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: Consumer<MyProvider>(
        builder: (context,yProvider,_){
          final myProvider = Provider.of<MyProvider>(context,listen: true);
          final myyProvider = Provider.of<MyProvider>(context,listen: true);
          return Center(
            child: FutureBuilder<String>(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display a loading indicator while waiting for the API response
                }
                // else if (snapshot.hasError) {
                //   return Text('Error: ${snapshot.error}');
                // }
                else {
                  final res;
                  if(snapshot.data!=null) {
                    print(snapshot.data!);
                    res = jsonDecode(snapshot.data!);
                    print(res["data"].length);
                  }
                  else
                    res=jsonDecode(response);


                  for(var i=0;i<res["data"].length;i++) {
                    try {
                      emps.add(Employee.fromJson(res["data"][i]));
                    }
                    catch(e)
                    {
                      print(e.toString());
                    }
                  }
                  final List<Employee> employees = emps;
                  return ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://picsum.photos/250?image=9'),
                                      ),
                                      title: Row(
                                        children: [
                                          Text(
                                            employees[index].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(onPressed: () async
                                          {
//update api

                                             showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {


                                                    return AlertDialog(
                                                      title: Text('Employee Update'),
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            controller: _nameController,
                                                            decoration: InputDecoration(
                                                              labelText: 'Name',
                                                            ),
                                                          ),
                                                          SizedBox(height: 16),
                                                          TextFormField(
                                                            controller: _ageController,
                                                            decoration: InputDecoration(
                                                              labelText: 'Age',
                                                            ),
                                                          ),
                                                          SizedBox(height: 16),
                                                          TextField(
                                                            controller: _salaryController,
                                                            decoration: InputDecoration(
                                                              labelText: 'Salary',
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
                                                          onPressed: () {

                                                            myyProvider.updatename(_nameController.text);
                                                            int age= int.parse(_ageController.text);
                                                            int sal= int.parse(_salaryController.text);
                                                            print('hel');
                                                            print(sal);
                                                            myyProvider.updateage(age);

                                                            myyProvider.updatesalary(sal);
                                                            employees[index]= Employee(id: index, name: _nameController.text,
                                                                salary: sal, age: age, image: "https://picsum.photos/250?image=9");

                                                            Navigator.of(context).pop();

                                                          },
                                                          child: Text('Submit'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                             int x= employees[index].id;
                                             int? age= int.tryParse(_ageController.text);
                                             int? sal= int.tryParse(_salaryController.text);
                                             await updateRecord(x,_nameController.text,sal,age);

                                          }, icon: Icon(
                                            Icons.edit_outlined
                                            ,
                                            color: Colors.blue,
                                          ))
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Salary: ${employees[index]
                                            .salary} , Age:${employees[index]
                                            .age}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      trailing: Container(
                                          child: IconButton(
                                            onPressed: () async{
//delete api
                                             await deleteRecord(index);

                                              setState(() {
                                                employees.removeAt(index);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete_outline_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
        }
      ),
      floatingActionButton: ClipOval(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder()
          ),


          onPressed: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEmp()),
            );
          },
        child: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
