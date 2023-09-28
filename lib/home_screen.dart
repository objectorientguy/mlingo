import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mlingo/configs.dart';

import 'add_key.dart';
import 'buttons.dart';
import 'models/table_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

final List<TableModel> rowDataList = [];

List<bool> selectedCheckboxes = [];

void addData() {
  rowDataList.clear();
  List keys = DatabaseUtil.box.keys.toList();
  for (String key in keys) {
    TableModel rowData = DatabaseUtil.box.get(key);

    rowDataList.add(rowData);
  }
  selectedCheckboxes = List.generate(rowDataList.length, (index) => false);
}

void deleteData() {
  List keys = DatabaseUtil.box.keys.toList();
  for (var i = 0; i < selectedCheckboxes.length; i++) {
    if (selectedCheckboxes[i] == true) {
      DatabaseUtil.box.delete(keys[i]);
    }
  }
  addData();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  // Create a list to store the selected checkboxes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mlingo', style: Theme.of(context).textTheme.heading),
                Row(
                  children: [
                    Visibility(
                        visible: selectedCheckboxes.contains(true),
                        child: CustomButtonFilled(
                            onTap: () {
                              setState(() {
                                deleteData();
                              });
                            },
                            icon: Icons.delete_outline,
                            label: 'Delete',
                            fillColor: AppColor.red)),
                    const CustomButton(
                        icon: Icons.filter_list, label: 'Filter'),
                    CustomButton(
                        icon: Icons.cloud_download_outlined,
                        label: 'Export',
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(12))),
                    CustomButtonFilled(
                        onTap: () async {
                          bool back = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddKeyScreen();
                          }));
                          if (back) {
                            log('here=====================>');
                            setState(() {
                              addData();
                            });
                          }
                        },
                        icon: Icons.add,
                        label: 'Add New',
                        fillColor: AppColor.blue),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: AppColor.grey,
            thickness: 0.2,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                DataTable(
                  columnSpacing: 0,
                  horizontalMargin: 30,
                  showCheckboxColumn: true,
                  headingRowHeight: 50,
                  dataRowMaxHeight: 50,
                  columns: [
                    DataColumn(
                      label: InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedCheckboxes.contains(false)) {
                                selectedCheckboxes = List.generate(
                                    rowDataList.length, (index) => true);
                              } else {
                                selectedCheckboxes;
                                selectedCheckboxes = List.generate(
                                    rowDataList.length, (index) => false);
                              }
                            });
                          },
                          child: Icon(
                              (selectedCheckboxes.contains(true) &&
                                      selectedCheckboxes.contains(false))
                                  ? Icons.indeterminate_check_box_outlined
                                  : (selectedCheckboxes.contains(true))
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                              color: (selectedCheckboxes.contains(true))
                                  ? AppColor.blue
                                  : AppColor.lightGrey)),
                    ),
                    DataColumn(
                        label: Text('Created by',
                            style: Theme.of(context)
                                .textTheme
                                .regular
                                .copyWith(fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Status',
                            style: Theme.of(context)
                                .textTheme
                                .regular
                                .copyWith(fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Key',
                            style: Theme.of(context)
                                .textTheme
                                .regular
                                .copyWith(fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('English',
                            style: Theme.of(context)
                                .textTheme
                                .regular
                                .copyWith(fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Hindi',
                            style: Theme.of(context)
                                .textTheme
                                .regular
                                .copyWith(fontWeight: FontWeight.w600))),
                  ],
                  rows: List<DataRow>.generate(
                    rowDataList.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCheckboxes[index] =
                                      !selectedCheckboxes[index];
                                });
                              },
                              child: Icon(
                                selectedCheckboxes[index]
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank_rounded,
                                color: selectedCheckboxes[index]
                                    ? AppColor.blue
                                    : AppColor.lightGrey,
                              )),
                        ),
                        DataCell(Text(rowDataList[index].createdBy,
                            style: Theme.of(context).textTheme.bold)),
                        DataCell(Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    (rowDataList[index].status == 'Published')
                                        ? AppColor.lightGreen
                                        : AppColor.lighterGrey),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.circle,
                                    size: 8,
                                    color: (rowDataList[index].status ==
                                            'Published')
                                        ? AppColor.green
                                        : AppColor.darkGrey),
                                const SizedBox(width: 6),
                                Text(rowDataList[index].status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .regular
                                        .copyWith(
                                            color: (rowDataList[index].status ==
                                                    'Published')
                                                ? AppColor.green
                                                : AppColor.darkGrey)),
                              ],
                            ))),
                        DataCell(Text(rowDataList[index].key,
                            style: Theme.of(context).textTheme.regular)),
                        DataCell(Text(rowDataList[index].english,
                            style: Theme.of(context).textTheme.regular)),
                        DataCell(Text(rowDataList[index].hindi,
                            style: Theme.of(context).textTheme.regular)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
