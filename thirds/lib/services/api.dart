import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thirds/model/product_model.dart';

class Api {
  static const baseUrl = "http://192.168.100.4/api/";

  // post method
  static Future<void> addProduct(Map<String, dynamic> pdata) async {
    debugPrint(pdata.toString());

    var url = Uri.parse("${baseUrl}add_product");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pdata),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        debugPrint(data.toString());
      } else {
        debugPrint("Failed to get response: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

// get method
  static Future<List<Product>> getProduct() async {
    List<Product> products = [];
    var url = Uri.parse("${baseUrl}get_product");

    try {
      final res = await http.get(url);
      debugPrint("API Response: ${res.body}");

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        if (data['products'] is List) {
          for (var value in data['products']) {
            products.add(Product(
              name: value['pname'] ?? 'Unknown',
              price: double.tryParse(value['pprice'].toString()) ?? 0.0,
              desc: value['pdesc'] ?? 'No description',
            ));
          }
        } else {
          debugPrint("Unexpected response format: ${res.body}");
        }
      } else {
        debugPrint("Failed to fetch products: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }

    return products;
  }
}
