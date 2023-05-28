import 'dart:convert';

import 'package:http/http.dart' as http;
deleteRecord(int index) async{
   final url = 'https://dummy.restapiexample.com/api/v1/delete/{$index}'; // Replace with your API endpoint URL

   try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
         // Deletion successful
         print('Data deleted successfully');
      } else {
         // Deletion failed
         print('Failed to delete data');
      }
   } catch (error) {
      // Error occurred during the request
      print('Error: $error');
   }
}

updateRecord(int index,String name,int? sal,int? age) async{
   var url = Uri.parse('https://dummy.restapiexample.com/api/v1/update/{$index}'); // API endpoint URL

   var body = jsonEncode({'name': name, 'age': "$age", "salary": "$sal"}); // Request body

   var response = await http.put(url, body: body);

   if (response.statusCode == 200) {
      // Request successful
      var responseData = jsonDecode(response.body);
      print('Data updated successfully: $responseData');
   } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
   }
}