// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController firstFieldController = TextEditingController();
//   TextEditingController secondFieldController = TextEditingController();
//   final items = ['One', 'Two', 'Three', 'Four'];
//   String selectedValue = 'Four';
//   final items2 = ['One', 'Two', 'Three', 'Four'];
//   String selectedValue2 = 'Two';
//    late String value, value2;
//   bool exchange = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//
//                     // dropdown below..
//                     child: DropdownButton<String>(
//                       value: selectedValue,
//                       onChanged: (String? newValue) =>
//                           setState(() => selectedValue = newValue!),
//                       items: items
//                           .map<DropdownMenuItem<String>>(
//                               (String value) => DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   ))
//                           .toList(),
//
//                       // add extra sugar..
//                       icon: const Icon(Icons.arrow_drop_down),
//                       iconSize: 42,
//                       underline: const SizedBox(),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 50,
//                   ),
//                   CircleAvatar(
//                     child: IconButton(
//                       onPressed: () {
//                         if( exchange =true)
//                         {
//                           selectedValue = value2;
//                           selectedValue = value;
//                         }
//
//                       },
//                       icon: const Icon(Icons.swap_horiz),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 50,
//                   ),
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: DropdownButton<String>(
//
//                       value: selectedValue2,
//                       onChanged: (String? newValue2) =>
//                           setState(() => selectedValue2 = newValue2!),
//                       items: items2
//                           .map<DropdownMenuItem<String>>(
//                               (String value2) => DropdownMenuItem<String>(
//
//                                     value: value2,
//                                     child: Text(value2),
//                                   ))
//                           .toList(),
//
//                       // add extra sugar..
//                       icon: Icon(Icons.arrow_drop_down),
//                       iconSize: 42,
//                       underline: const SizedBox(),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:apis_test/api/data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initial Selected Value

  ModelController modelController = Get.put(ModelController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modelController.fetchData().then((value) {
      // print(value);
      modelController.dropdownvalue = modelController.data1[0];
      modelController.dropdownvalue2 = modelController.data1[0];
    });
  }

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modelController.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetBuilder(
                          init: modelController,
                          builder: (controller) => Expanded(
                            //  From
                            child: DropdownButton(
                              // Initial Value
                              value: modelController.dropdownvalue,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: modelController.data1.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                modelController.dropdownvalue = newValue!;
                                modelController.update();
                                modelController.opt1 = newValue;
                                modelController.update();
                                if (kDebugMode) {
                                  print(modelController.opt1);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          onPressed: () {
                            modelController.swapData();
                            modelController.update();
                          },
                          icon: const Icon(Icons.swap_horiz),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GetBuilder(
                          builder: (controller) => Expanded(
                            child: DropdownButton(
                              // Initial Value
                              value: modelController.dropdownvalue2,
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: modelController.data1.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                modelController.dropdownvalue2 = newValue!;
                                modelController.update();
                                modelController.opt2 = newValue;
                                modelController.update();
                                if (kDebugMode) {
                                  print(modelController.opt2);
                                }
                              },
                            ),
                          ),
                          init: modelController,
                        ),
                      ],
                    ),
                    const Text('From'),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(.5),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: TextFormField(
                                controller: modelController.numController,
                                onChanged: (value) {
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 50,
                          ),
                          onPressed: () async {
                            // Show the CircularProgressIndicator during the delay
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            // Perform the delayed operation
                            await Future.delayed(Duration(seconds: 3));

                            // Dismiss the CircularProgressIndicator dialog
                            Navigator.of(context).pop();

                            // Continue with the rest of your logic
                            setState(() async {
                              modelController.update();
                              await modelController.convertData();
                            });
                          },
                        ),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[600]!.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Center(
                                  child: GetBuilder(
                                builder: (controller) =>
                                    Text('${modelController.result}'),
                                init: modelController,
                              ))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Text('loading');
        }
      },
    );
  }
}
