import 'package:emp_record/views/all_emp.dart';
import 'package:flutter/cupertino.dart';

import '../model/employee.dart';

class ListProvider extends ChangeNotifier {
  List<Employee> _items = emps;

  List<Employee> get items => _items;

  void deleteItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
}
class MyProvider with ChangeNotifier {
  String name=" ";
   int age=0;
   int salary=0;

  void updatename(String value) {
    name = value;
    notifyListeners();
  }

  void updateage(int value) {
    age = value;
    notifyListeners();
  }

  void updatesalary(int value) {
    salary = value;
    notifyListeners();
  }
}