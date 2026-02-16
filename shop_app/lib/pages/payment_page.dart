import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class PaymentPage extends StatelessWidget {
  final cardNo = TextEditingController();
  final name = TextEditingController();
  final cvv = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Ödeme", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            ///  kart görseli
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fake Bank",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 20),
                  Text("**** **** **** 4242",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2)),
                  SizedBox(height: 20),
                  Text("Flutter User",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            SizedBox(height: 40),

            TextField(
              controller: cardNo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Kart Numarası",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Kart Sahibi",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: cvv,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "CVV",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: 30),

            ///  toplam fiyat
            Text("Toplam: \$${cart.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

            SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {

                if(cardNo.text.isEmpty || name.text.isEmpty || cvv.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Kart bilgilerini gir"))
                  );
                  return;
                }

                /// fake ödeme delay
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(child: CircularProgressIndicator()),
                );

                await Future.delayed(Duration(seconds: 2));

                Navigator.pop(context); // loading kapat

                cart.items.clear();
                cart.notifyListeners();

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Ödeme Başarılı 🎉"),
                    content: Text("Siparişiniz alındı"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Tamam"),
                      )
                    ],
                  ),
                );
              },
              child: Text("Ödeme Yap", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
