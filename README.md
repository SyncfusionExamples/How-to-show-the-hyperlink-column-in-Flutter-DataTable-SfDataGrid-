# How to show the hyperlink column in Flutter DataTable SfDataGrid

The Flutter DataTable widget allows you to load any type of widget into each cell. To display the hyperlink column, create a hyperlink like appearance using the Text widget and return it in DataGridSource.buildRow.

The following steps explain how to show the hyperlink column in Flutter DataTable,

## STEP 1: To launch the URL in the browser, add the following dependencies in pubspec.yaml.
```xml
dependencies:
  flutter:
    sdk: flutter
  url_launcher: ^6.0.9
```

## Step 2
Create an EmployeeDataGridSource class that extends the DataGridSource for mapping data to the SfDataGrid. Return the DataGridRowAdapter after overriding the buildRow method. Wrap the Text widget within the GestureDetecor widget. Provide the appropriate hyperlink to the GestureDetector widgets’ onTap callback. And then wrap the GestureDetector within the Container widget. Then, set the TextDecoration as an underline for the Text widget to give the hyperlink appearance.

Here, we have provided the hyperlink for a location column alone. Also, we have provided a container widget for the other columns.

```xml
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
}
```

## STEP 3: Initialize the SfDataGrid with all the required properties. 

```xml
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Datagrid Sample'),
      ),
      body: _buildDataGrid(),
    );
  }
```
 

