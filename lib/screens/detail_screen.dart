import "package:flutter/material.dart";

class DetailScreen extends StatelessWidget {
  // 1. Declare the properties
  final String name;
  final int age;
  final String city;

  // 2. Add them to the constructor
  const DetailScreen({
    super.key,
    required this.name,
    required this.age,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(child: Text("Name: $name, Age: $age, City: $city")),
    );
  }
}
