import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  List<Product> items = [];

  List<Product> get cartItems => items;

  void addToCart(Product product) {
    var existing = items.where((p) => p.id == product.id).toList();

    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      product.quantity = 1;
      items.add(product);
    }
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    product.quantity--;
    if (product.quantity <= 0) {
      items.remove(product);
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
