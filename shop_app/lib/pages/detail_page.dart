import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import 'login_page.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔥 APPBAR FIX
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // geri tuşu beyaz
        title: Text(
          "Product Detail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      // 🔥 ADD TO CART SABİT ALTTA
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {

  final auth = Provider.of<AuthProvider>(context, listen: false);

  if (!auth.isLoggedIn) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
    return;
  }

  Provider.of<CartProvider>(context, listen: false)
      .addToCart(product);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Sepete eklendi")),
  );
},
          child: Text(
            "Sepete Ekle - \$${product.price}",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),

      // 🔥 BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ürün görseli
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(product.image, height: 220),
                ),
              ),

              SizedBox(height: 25),

              // Başlık
              Text(
                product.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              // Fiyat
              Text(
                "\$${product.price}",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 20),

              Divider(),

              SizedBox(height: 10),

              Text(
                "Ürün Açıklaması",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text(
                product.description,
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
