import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {

  static Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    final data = jsonDecode(res.body);
    return data.map<Product>((e) => Product.fromJson(e)).toList();
  }


  static Future<List<String>> fetchCategories() async {
    final res = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
    final data = jsonDecode(res.body);
    return List<String>.from(data);
  }


  static Future<List<Product>> fetchByCategory(String cat) async {
    final res = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/$cat'));
    final data = jsonDecode(res.body);
    return data.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
