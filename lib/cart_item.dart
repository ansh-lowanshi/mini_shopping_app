class CartItem {
  final Map<String, dynamic> product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  // Convert CartItem to a Map for saving to SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }

  // Convert Map to CartItem for loading from Shared Preferences
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json['product'],
      quantity: json['quantity'],
    );
  }

  // Override equality for CartItem to compare the product's id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.product['id'] == product['id'];
  }

  @override
  int get hashCode => product['id'].hashCode;
}
