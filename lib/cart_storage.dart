import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_item.dart';

class CartStorage {
  // Save the cart items to SharedPreferences
  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson = cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart', cartJson);
  }

  // Load the cart items from SharedPreferences
  Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart');
    
    if (cartJson == null) return [];
    
    return cartJson.map((item) => CartItem.fromJson(jsonDecode(item))).toList();
  }
}
