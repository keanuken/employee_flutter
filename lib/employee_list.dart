import 'dart:convert';
import 'dart:async';

import 'package:employee_flutter/employee_model.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'restapi.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  DataService ds = DataService();

  List data = [];
  List<EmployeeModel> employee = [];

  selectAllEmployee() async {
    data = jsonDecode(await ds.selectAll('63476b4599b6c11c094bd50e', 'office',
        'employee', '63476ce899b6c11c094bd5e7'));
    employee = data.map((e) => EmployeeModel.fromJson(e)).toList();

    setState(() {
      employee = employee;
    });
  }

  FutureOr reloadDataEmployee(dynamic value) {
    setState(() {
      employee = employee;
    });
  }

  @override
  void initState() {
    selectAllEmployee();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, ‘employee_form_add');
                  Navigator.pushNamed(context, 'employee_form_add')
                      .then(reloadDataEmployee);
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )), // GestureDetector // Padding
        ], // <Widget>[]
      ), // AppBar
      body: ListView.builder(
        itemCount: employee.length,
        itemBuilder: (context, index) {
          final item = employee[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.birthday),
            onTap: () {
              Navigator.pushNamed(context, 'employee_detail',
                  arguments: [item.id]).then(reloadDataEmployee);
            },
          );
        },
      ),
    );
  }
}
