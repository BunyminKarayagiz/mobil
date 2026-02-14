import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Profil", style: TextStyle(color: Colors.black)),
      ),

      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 40),

            Center(
              child: Icon(Icons.person, size: 90, color: Colors.black),
            ),

            SizedBox(height: 20),

            Center(
              child: Text(
                auth.userEmail  ?? "Kullanıcı",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 50),

            ElevatedButton(
  onPressed: () async {
    await context.read<AuthProvider>().logout();
    Navigator.pop(context);
  },
  child: Text("Logout"),
)

          ],
        ),
      ),
    );
  }
}
