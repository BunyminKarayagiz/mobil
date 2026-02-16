import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';
import 'detail_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  List<String> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  fetchAll() async {
    products = await ApiService.fetchProducts();
    categories = await ApiService.fetchCategories();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Color(0xfff5f5f7),

      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f7),
        elevation: 0,
        title: Text("Apple Store",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        actions: [

          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_bag_outlined,
                        color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartPage()));
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle),
                        child: Text(cart.items.length.toString(),
                            style: TextStyle(
                                color: Colors.white, fontSize: 11)),
                      ),
                    )
                ],
              );
            },
          ),

          ///  PROFILE
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              if (auth.userEmail == null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LoginPage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfilePage()));
              }
            },
          ),
        ],
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [

                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Discover\nPremium Products",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.2),
                  ),
                ),

                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      CategoryPage(category: categories[i])));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          child: Text(categories[i].toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500)),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 25),


                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(15),
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final p = products[i];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailPage(product: p)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                offset: Offset(0, 6))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// image
                            Expanded(
                              child: Center(
                                child: Image.network(p.image, height: 120),
                              ),
                            ),

                            SizedBox(height: 10),

                            Text(p.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600)),

                            SizedBox(height: 6),

                            Text("\$${p.price}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),

                            SizedBox(height: 10),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(12)),
                              child: Center(
                                  child: Text("View",
                                      style: TextStyle(
                                          color: Colors.white))),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 30)
              ],
            ),
    );
  }
}
