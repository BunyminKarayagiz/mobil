import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sepetim", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      //  SEPET BOŞSA
      body: cart.items.isEmpty
          ? Center(
              child: Text(
                "Sepet boş 😢",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )

          //  DOLUYSA
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Image.network(item.image, height: 60, width: 60),
                            SizedBox(width: 15),

                            // başlık + fiyat
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Text("\$${item.price}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),

                            // adet kontrol
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cart.decreaseQuantity(item);
                                  },
                                ),
                                Text(item.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cart.increaseQuantity(item);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ALT TOPLAM VE CHECKOUT
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Toplam",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "\$${cart.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    minimumSize: Size(double.infinity, 55),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaymentPage()),
    );
  },
  child: Text("Ödeme Yap"),
),        
                    ],
                  ),
                  
                )
              ],
            ),
    );
  }
}
