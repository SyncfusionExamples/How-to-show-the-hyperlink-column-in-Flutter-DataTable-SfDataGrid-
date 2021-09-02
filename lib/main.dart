import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late _EmployeeDataGridSource employeeDataGridSource;

  SfDataGrid _buildDataGrid() {
    return SfDataGrid(
      source: employeeDataGridSource,
      columns: <GridColumn>[
        GridColumn(
            width: 115,
            columnName: 'employeeName',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Name',
                overflow: TextOverflow.ellipsis,
              ),
            )),
        GridColumn(
          columnName: 'designation',
          width: 130,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Designation',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'location',
          width: 105.0,
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Location',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerRight,
              child: const Text(
                'Salary',
                overflow: TextOverflow.ellipsis,
              )),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    employeeDataGridSource = _EmployeeDataGridSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Datagrid Sample'),
      ),
      body: _buildDataGrid(),
    );
  }
}

class _Employee {
  _Employee(
    this.employeeName,
    this.designation,
    this.location,
    this.salary,
  );
  final String location;
  final String employeeName;
  final String designation;
  final int salary;
}

class _EmployeeDataGridSource extends DataGridSource {
  _EmployeeDataGridSource() {
    employees = getEmployees(20);
    buildDataGridRows();
  }

  final math.Random random = math.Random();
  List<DataGridRow> dataGridRows = <DataGridRow>[];
  List<_Employee> employees = <_Employee>[];

  void buildDataGridRows() {
    dataGridRows = employees.map<DataGridRow>((_Employee employee) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(
            columnName: 'employeeName', value: employee.employeeName),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        DataGridCell<String>(columnName: 'location', value: employee.location),
        DataGridCell<int>(columnName: 'salary', value: employee.salary),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => dataGridRows;

  Widget buildLocation(dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: getWidget(
          const Icon(
            Icons.location_on,
            size: 20,
            color: Colors.blue,
          ),
          value),
    );
  }

  Widget getWidget(Widget image, String text) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Container(
            child: image,
          ),
          const SizedBox(width: 6),
          Expanded(
              child: GestureDetector(
            onTap: () => _launchURL(locationURL[text]!),
            child: Text(
              text,
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
              overflow: TextOverflow.ellipsis,
            ),
          ))
        ],
      ),
    );
  }

  _launchURL(String hyperlink) async {
    if (await canLaunch(hyperlink)) {
      await launch(hyperlink);
    } else {
      throw 'Could not launch $hyperlink';
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(row.getCells()[1].value.toString()),
      ),
      buildLocation(row.getCells()[2].value),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(NumberFormat.currency(locale: 'en_US', symbol: r'$')
            .format(row.getCells()[3].value)
            .toString()),
      ),
    ]);
  }

  // Employee Data's

  final List<String> employeeNames = <String>[
    'Michael',
    'Kathryn',
    'Tamer',
    'Martin',
    'Davolio',
    'Nancy',
    'Fuller',
    'Leverling',
    'Therasa',
    'Margaret',
    'Buchanan',
    'Janet',
    'Andrew',
    'Callahan',
    'Laura',
    'Dodsworth',
    'Anne',
    'Bergs',
    'Vinet',
    'Anto',
    'Fleet',
    'Zachery',
    'Van',
    'Edward',
    'Jack',
    'Rose'
  ];

  final List<String> designations = <String>[
    'Designer',
    'Manager',
    'Developer',
    'Project Lead',
    'Program Directory',
    'System Analyst',
    'CFO'
  ];
  final List<String> mails = <String>[
    'arpy.com',
    'sample.com',
    'rpy.com',
    'jourrapide.com'
  ];

  final List<String> locations = <String>[
    'UK',
    'USA',
    'Sweden',
    'France',
    'Canada',
    'Argentina',
    'Austria',
    'Germany',
    'Mexico'
  ];

  final Map<String, String> locationURL = {
    'UK': 'https://en.wikipedia.org/wiki/United_Kingdom',
    'USA': 'https://en.wikipedia.org/wiki/United_States',
    'Sweden': 'https://en.wikipedia.org/wiki/Sweden',
    'France': 'https://en.wikipedia.org/wiki/France',
    'Canada': 'https://en.wikipedia.org/wiki/Canada',
    'Argentina': 'https://en.wikipedia.org/wiki/Argentina',
    'Austria': 'https://en.wikipedia.org/wiki/Austria',
    'Germany': 'https://en.wikipedia.org/wiki/Germany',
    'Mexico': 'https://en.wikipedia.org/wiki/Mexico',
  };

  List<_Employee> getEmployees(int count) {
    final List<_Employee> employeeData = <_Employee>[];
    for (int i = 0; i < employeeNames.length - 1; i++) {
      employeeData.add(_Employee(
        employeeNames[i],
        designations[random.nextInt(designations.length - 1)],
        locations[random.nextInt(locations.length - 1)],
        10000 + random.nextInt(70000),
      ));
    }
    return employeeData;
  }
}
