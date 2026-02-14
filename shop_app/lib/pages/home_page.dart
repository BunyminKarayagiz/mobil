import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';
import 'detail_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import '../providers/cart_provider.dart';
import 'profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import '../providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  List<String> categories = [];
  bool loading = true;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    fetchAll();
    loadUser(); // 🔥 kullanıcıyı çek
  }

  /// 🔥 USER OKU
  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString("userEmail");
    });
  }

  /// 🔥 API
  fetchAll() async {
    products = await ApiService.fetchProducts();
    categories = await ApiService.fetchCategories();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔥 APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Shop App", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [

          /// 🛒 SEPET ICON + BADGE
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartPage()),
                      );
                    },
                  ),

                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.items.length.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                ],
              );
            },
          ),

          /// 👤 PROFILE ICON
IconButton(
  icon: Icon(Icons.person, color: Colors.black),
  onPressed: () {
    final auth = context.read<AuthProvider>();

    if (!auth.isLoggedIn) {
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

      /// 🔥 BODY
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔥 USER TEXT (debug istersen sil)
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 5),
                  child: Text(
                    userEmail != null
                        ? "Misafir kullanıcı"
                        : "Hoşgeldin ${userEmail!.split("@")[0]}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                
                SizedBox(height: 10),

                /// 🔥 KATEGORİLER
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
                                  CategoryPage(category: categories[i]),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              categories[i].toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                /// 🔥 PRODUCT GRID
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(15),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
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
                              builder: (_) => DetailPage(product: p),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(p.image),
                              ),
                              SizedBox(height: 10),
                              Text(
                                p.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text("\$${p.price}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
