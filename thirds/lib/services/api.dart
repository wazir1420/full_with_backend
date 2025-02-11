import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thirds/model/product_model.dart';

class Api {
  static const baseUrl = "http://192.168.100.4/api/";

  // POST method - Add Product
  static Future<void> addProduct(Map<String, dynamic> pdata) async {
    debugPrint("Sending product data: $pdata");
    var url = Uri.parse("${baseUrl}add_product");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pdata),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint("Product Added: $data");
      } else {
        debugPrint("Failed to add product: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in addProduct: $e");
    }
  }

  // GET method - Fetch Products
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
              id: value['_id'].toString(),
            ));
          }
        } else {
          debugPrint("Unexpected response format: ${res.body}");
        }
      } else {
        debugPrint("Failed to fetch products: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in getProduct: $e");
    }

    return products;
  }

  // PUT method - Update Product
  static Future<void> updateProduct(
      String? id, Map<String, dynamic> body) async {
    if (id == null || id.isEmpty) {
      debugPrint("Invalid product ID for update.");
      return;
    }

    var url = Uri.parse("${baseUrl}update/$id");
    try {
      final res = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint("Update Response: ${res.body}");
      if (res.statusCode == 200) {
        debugPrint("Product updated successfully");
      } else {
        debugPrint("Failed to update product: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in updateProduct: $e");
    }
  }

  // DELETE method - Delete Product
  static Future<bool> deleteProduct(String id) async {
    if (id.isEmpty) {
      debugPrint("Invalid product ID for delete.");
      return false;
    }
    var url = Uri.parse("${baseUrl}delete/$id");
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        debugPrint("Product deleted successfully: ${res.body}");
        return true;
      } else {
        debugPrint("Failed to delete product: ${res.statusCode} - ${res.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Error deleting product: $e");
      return false;
    }
  }
}
