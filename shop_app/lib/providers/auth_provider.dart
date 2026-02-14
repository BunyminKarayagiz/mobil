import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? userEmail;
  bool isLoading = true;

  AuthProvider() {
    loadUser();
  }

  /// 🔥 app açılınca user oku
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("userEmail");
    isLoading = false;
    notifyListeners();
  }

  /// 🔥 login
  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userEmail", email);
    userEmail = email;

    notifyListeners();
  }

  /// 🔥 logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("userEmail");
    userEmail = null;
    notifyListeners();
  }

  bool get isLoggedIn => userEmail != null;
}
