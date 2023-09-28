import 'package:flutter/material.dart';
import 'buttons.dart';
import 'configs.dart';
import 'models/table_model.dart';

class AddKeyScreen extends StatelessWidget {
  const AddKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Map dataMap = {};
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mlingo', style: Theme.of(context).textTheme.heading),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: AppColor.grey,
            thickness: 0.2,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 700,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            title: 'Key',
                            onChange: (value) {
                              dataMap['key'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter a Value';
                              }
                              return null;
                            }),
                        CustomTextField(
                            title: 'English',
                            onChange: (value) {
                              dataMap['english'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter a Value';
                              }
                              return null;
                            }),
                        CustomTextField(
                          title: 'Hindi',
                          onChange: (value) {
                            dataMap['hindi'] = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButtonFilled(
                                icon: Icons.save_alt_outlined,
                                label: 'Save as draft',
                                fillColor: AppColor.blue,
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    DatabaseUtil.box.put(
                                        dataMap['key'],
                                        TableModel(
                                            createdBy: 'Aditya',
                                            status: 'Unpublished',
                                            key: dataMap['key'],
                                            english: dataMap['english'] ?? '',
                                            hindi: dataMap['hindi'] ?? ''));
                                    Navigator.pop(context, true);
                                  }
                                }),
                            CustomButtonFilled(
                              icon: Icons.publish_outlined,
                              label: 'Publish',
                              fillColor: AppColor.blue,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  DatabaseUtil.box.put(
                                      dataMap['key'],
                                      TableModel(
                                          createdBy: 'Aditya',
                                          status: 'Published',
                                          key: dataMap['key'],
                                          english: dataMap['english'] ?? '',
                                          hindi: dataMap['hindi'] ?? ''));
                                  Navigator.pop(context, true);
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.title,
    this.onChange,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            border: Border(left: BorderSide(width: 3, color: AppColor.grey))),
        child: Focus(
          onFocusChange: (isFocus) {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.regularSmall),
              const SizedBox(height: 2),
              TextFormField(
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
                validator: validator,
                onChanged: onChange,
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Max 50 Characters',
                      style: Theme.of(context).textTheme.regularSmall)
                ],
              )
            ],
          ),
        ));
  }
}
