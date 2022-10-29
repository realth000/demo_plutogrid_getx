import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/",
    getPages: [
      GetPage(name: "/", page: () => TablePage()),
    ],
  ));
}

class TablePageController extends GetxController {
  final rowData = <String>[].obs;

  void updateData() {
    final rowData2 = <String>[];
    print('before ${rowData}');
    for (final data in rowData) {
      rowData2.add((int.parse(data) + 2).toString());
    }
    rowData2.add((rowData2.length + 1).toString());
    rowData.value = rowData2;
    print('after ${rowData}');
  }
}

class TablePage extends StatelessWidget {
  final controller = Get.put(TablePageController());

  final columns = <PlutoColumn>[
    PlutoColumn(
        title: 'Title 1', field: 'title 1', type: PlutoColumnType.text()),
    PlutoColumn(
        title: 'Title 2', field: 'title 2', type: PlutoColumnType.text()),
  ];

  List<PlutoRow> _buildRows(List<String> rowData) => List.generate(
      rowData.length,
      (index) => PlutoRow(cells: {
            'title 1': PlutoCell(value: rowData[index]),
            'title 2': PlutoCell(value: rowData[index]),
          }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlutoGrid GetX Demo'),
      ),
      body: Obx(
        () => PlutoGrid(
          columns: columns,
          rows: _buildRows(controller.rowData),
          key: UniqueKey(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.updateData();
        },
      ),
    );
  }
}
