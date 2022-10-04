import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Horario DAM-2 2022/2023';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(width: double.infinity),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                child: DataTable(
                  border: TableBorder.all(width: 3.0,color:Colors.grey),
                    headingRowHeight: 20,
                    dataRowHeight: 50,
                    columns: [
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints.expand(
                          ),
                          child: Text(''),
                        ),
                      ),
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 20,
                          ),
                          child: Text('Lunes'),
                        ),
                      ),
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 20,
                          ),
                          child: Text('Martes'),
                        ),
                      ),
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 20,
                          ),
                          child: Text('Miercoles'),
                        ),
                      ),
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 20,
                          ),
                          child: Text('Jueves'),
                        ),
                      ),
                      DataColumn(
                        label: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            minWidth: 20,
                          ),
                          child: Text('Viernes'),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: double.infinity,
                                minWidth: double.infinity,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Container(
                            color: Colors.grey,
                            child: ConstrainedBox(
                              constraints: BoxConstraints.expand(
                              ),
                              child: Text('2'),
                            ),
                          )),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 50,
                                minWidth: 20,
                              ),
                              child: Text('15:00\n16:00'),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
