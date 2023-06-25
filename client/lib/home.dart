import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = fetchAppleData();
  }

  Future<List<dynamic>> fetchAppleData() async {
    final response = await http
        .get(Uri.parse('https://brindle-aboard-manatee.glitch.me/appleData'));

    if (response.statusCode == 200) {
      print(response.body);
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: fetchAppleData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<dynamic> dataList = snapshot.data!;

              return DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('YOP')),
                    DataColumn(label: Text('Breed')),
                    DataColumn(label: Text('Row')),
                    DataColumn(label: Text('Col')),
                    DataColumn(label: Text('Geolocation')),
                  ],
                  rows: dataList.map<DataRow>((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['ID'].toString())),
                      DataCell(Text(item['YOP'].toString())),
                      DataCell(Text(item['Breed'].toString())),
                      DataCell(Text(item['Row'].toString())),
                      DataCell(Text(item['Col'].toString())),
                      DataCell(Text(item['Geolocation'].toString())),
                    ]);
                  }).toList());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/register");
        },
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
