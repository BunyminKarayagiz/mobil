import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 40),

            Text("Welcome Back",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 40),

            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {

                final mail = email.text.trim();
                final password = pass.text.trim();

                if (mail.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Email ve şifre gir")),
                  );
                  return;
                }

                await context.read<AuthProvider>().login(mail, password);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Giriş başarılı")),
                );

                Navigator.pop(context); // geri dön home
              },
              child: Text("Login", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
