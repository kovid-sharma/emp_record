class Employee {
  final int id;
  final String name;
   final int salary;
  final int age;
  final String image;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
    required this.image,
  });
  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["employee_name"],
    salary: json["employee_salary"],
    age: json["employee_age"],
    image: json["profile_image"]
  );
}