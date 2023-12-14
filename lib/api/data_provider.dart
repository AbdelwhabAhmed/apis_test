
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;





class ModelController extends GetxController  {

  var numController= TextEditingController();
  var opt1;
  var opt2;
 var result;
  List<String> data1 =[];
  Map<String, dynamic> jData = {};
  double? numResult;
  Future<Map<String,dynamic>> fetchData()async {

    final url = Uri.parse('https://api.apilayer.com/currency_data/list');
    var headers = {
      "apikey": "Xa5CeCSh7Pca1NAeACGxJ65zuVjBvV24"
    };
    final response = await http.get(url, headers: headers,);
    if (response.statusCode == 200) {
      final body = response.body;
      final data = jsonDecode(body) as Map<String, dynamic>;
      Map<String, dynamic> currencies = data['currencies'];
      jData=currencies;
      List<String> key = currencies.keys.toList();
      data1=key;
       update();
      List value =currencies.values.toList();
      // print(currencies);
      // print(value[3]);
      // print(key[3]);

      return data;
    } else {
      // do any thing.
      throw Exception("Invalid response");
    }
  }


  Future  convertData() async {
    var headers = {
      'apikey': 'Xa5CeCSh7Pca1NAeACGxJ65zuVjBvV24'
    };
    final url = Uri.parse('https://api.apilayer.com/currency_data/convert?to=$opt2&from=$opt1&amount=${numController.text}');
    final response =await http.get(url,headers: headers, );

    if (response.statusCode == 200) {

      final body2 = response.body;
      final data2 = jsonDecode(body2) as Map<String,dynamic>;
      var numResult = data2['result'];

      if (kDebugMode) {
        print(numResult);
      }
       if (kDebugMode) {
         print(data2.keys);
         print(opt1);
         print(opt2);
       }
      if (kDebugMode) {
        print(data2.values);
      }
      result =numResult;

      update();
      return numResult;


    }
    else {
      throw Exception("Invalid response");
    }

  }
  String dropdownvalue = '';
  String dropdownvalue2 = '';

  void swapData() {
    String temp = dropdownvalue;

      dropdownvalue = dropdownvalue2;
      dropdownvalue2 = temp;
      opt1=dropdownvalue;
      opt2=dropdownvalue2;
      update();
  }

}