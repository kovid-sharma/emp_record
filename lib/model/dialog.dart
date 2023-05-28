import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/listview_provider.dart';
class MyCustomDialog extends StatefulWidget {

  const MyCustomDialog({super.key,required this.index});
  final int index;
  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}
class _MyCustomDialogState extends State<MyCustomDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context,listen: true);
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
            myProvider.updatename(_nameController.text);
            int age= int.parse(_ageController.text);
            int sal= int.parse(_salaryController.text);
            print('hel');
            print(sal);
            myProvider.updateage(age);
            myProvider.updatesalary(sal);
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}