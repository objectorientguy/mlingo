import 'package:flutter/material.dart';

class RowData {
  String createdAt;
  String status;
  String key;
  String english;
  String hindi;

  RowData({
    required this.createdAt,
    required this.status,
    required this.key,
    required this.english,
    required this.hindi,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}
final List<RowData> rowDataList = [
  RowData(
      createdAt: 'Aditya',
      status: 'Unpublished',
      key: 'hello',
      english: 'Hello',
      hindi: 'नमस्ते'),
  RowData(
      createdAt: 'Saurabh',
      status: 'Unpublished',
      key: 'how_are_you',
      english: 'How are you',
      hindi: 'आप कैसे हैं?'),
  RowData(
      createdAt: 'Ketan',
      status: 'Published',
      key: 'what',
      english: 'What?',
      hindi: 'क्या?'),
  RowData(
      createdAt: 'Vishal',
      status: 'Published',
      key: 'i_am_doing_good',
      english: 'I am doing good!',
      hindi: 'मैं अच्छा कर रहा हूँ'),
];
class HomeScreenState extends State<HomeScreen> {


  // Create a list to store the selected checkboxes

  List<bool> selectedCheckboxes =
      List.generate(rowDataList.length, (index) => false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mlingo',style: Theme.of(context).textTheme.heading),
                  Row(
                    children: [
                      Visibility(visible: selectedCheckboxes.contains(true),child: const CustomButton(icon: Icons.delete_outline, label: 'Delete')),
                      const CustomButton(icon: Icons.filter_list, label: 'Filter'),
                      CustomButton(
                          icon: Icons.download_outlined,
                              label: 'Export',
                              decoration: BoxDecoration(
                               border: Border.all(color: AppColor.grey,width: 0.5),
                               borderRadius: BorderRadius.circular(12)
                              )),
                      TextButton.icon(
                          onPressed: (){},
                          icon: const Icon(Icons.add),
                          label: const Text('Add New')),
                    ],
                  )
                ],
              ),
            ),
            const Divider(height: 0,color: AppColor.grey,thickness: 0.2,),
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
                      DataColumn(label: SizedBox(width: 30,
                        child: InkWell(
                            onTap:(){
                              setState(() {
                                // selectedCheckboxes[index] = !selectedCheckboxes[index];
                              });
                            } ,
                            child: Icon(
                              selectedCheckboxes.contains(false)
                                  ?Icons.indeterminate_check_box_outlined
                                  :Icons.check_box,
                              color: AppColor.blue
                            )),
                      ),),
                      DataColumn(label: Text('Created by',style: Theme.of(context).textTheme.regular.copyWith(fontWeight: FontWeight.w600))),
                      DataColumn(label: Text('Status',style: Theme.of(context).textTheme.regular.copyWith(fontWeight: FontWeight.w600))),
                      DataColumn(label: Text('Key',style: Theme.of(context).textTheme.regular.copyWith(fontWeight: FontWeight.w600))),
                      DataColumn(label: Text('English',style: Theme.of(context).textTheme.regular.copyWith(fontWeight: FontWeight.w600))),
                      DataColumn(label: Text('Hindi',style: Theme.of(context).textTheme.regular.copyWith(fontWeight: FontWeight.w600))),
                    ],
                    rows: List<DataRow>.generate(
                      rowDataList.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            SizedBox(width:30,
                              child: InkWell(
                                onTap:(){
                                  setState(() {
                                    selectedCheckboxes[index] = !selectedCheckboxes[index];
                                  });
                                } ,
                                child: Icon(
                                  selectedCheckboxes[index]
                                      ?Icons.check_box
                                      :Icons.check_box_outline_blank_rounded,
                                  color: selectedCheckboxes[index]
                                      ?AppColor.blue
                                      :Colors.grey[400],
                                )),
                            ),),
                          DataCell(Text(rowDataList[index].createdAt,style: Theme.of(context).textTheme.bold),
                          onDoubleTap: (){}),
                          DataCell(Text(rowDataList[index].status,style: Theme.of(context).textTheme.regular)),
                          DataCell(Text(rowDataList[index].key,style: Theme.of(context).textTheme.regular)),
                          DataCell(Text(rowDataList[index].english,style: Theme.of(context).textTheme.regular)),
                          DataCell(Text(rowDataList[index].hindi,style: Theme.of(context).textTheme.regular)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool border;
  final void Function()? onTap;
  final Decoration? decoration;
  const CustomButton({
    super.key, required this.icon, required this.label, this.border = false, this.onTap, this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 30
          ),
          decoration: decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,color: AppColor.blueGrey,size: 22),
              const SizedBox(width: 9),
              Text(label,style: Theme.of(context).textTheme.buttonText),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColor{
  static const Color blue = Color(0xff0070ff);
  static const Color blueGrey = Color(0xff344155);
  static const Color grey = Color(0xff7a8294);
  static const Color black = Color(0xff000000);
}

extension AppTextTheme on TextTheme {
  TextStyle get regular {
    return const TextStyle(
        fontSize: 14, color: AppColor.grey, fontWeight: FontWeight.w500);
  }

  TextStyle get bold {
    return const TextStyle(
        fontSize: 14, color: AppColor.black, fontWeight: FontWeight.w600);
  }

  TextStyle get heading {
    return const TextStyle(
        fontSize: 26, color: AppColor.black, fontWeight: FontWeight.w600);
  }

  TextStyle get buttonText {
    return const TextStyle(
        fontSize: 16, color: AppColor.blueGrey, fontWeight: FontWeight.w500);
  }
}