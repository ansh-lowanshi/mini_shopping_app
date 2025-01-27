import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_item.dart';
import 'cart_storage.dart';

// prover to manage the states
final cartStorageProvider = Provider<CartStorage>((ref) {
  return CartStorage();
});

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  final Ref ref;

  CartNotifier(this.ref) : super([]) {
    _loadCart();
  }

  // Load cart from Shared Preferences on the start of app
  Future<void> _loadCart() async {
    final cartStorage = ref.read(cartStorageProvider);
    final savedCart = await cartStorage.loadCart();
    state = savedCart;
  }

  // Add product to cart or increase quantity 
  void addToCart(Map<String, dynamic> product) {
    final existingItemIndex =
        state.indexWhere((item) => item.product['id'] == product['id']);
    if (existingItemIndex == -1) {
      state = [
        ...state,
        CartItem(product: product, quantity: 1),
      ];
    } else {
      final updatedItem = CartItem(
        product: product,
        quantity: state[existingItemIndex].quantity + 1,
      );
      state = [
        ...state.sublist(0, existingItemIndex),
        updatedItem,
        ...state.sublist(existingItemIndex + 1)
      ];
    }

    _saveCart(); // Save cart to Shared Preferences
  }

  // Increase quantity of the product
  void increaseQuantity(CartItem cartItem) {
    final index = state.indexOf(cartItem);
    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        CartItem(
          product: cartItem.product,
          quantity: cartItem.quantity + 1,
        ),
        ...state.sublist(index + 1)
      ];
      _saveCart(); // Save cart to Shared Preferences
    }
  }

  // Decrease quantity of the product
  void decreaseQuantity(CartItem cartItem) {
    final index = state.indexOf(cartItem);
    if (index != -1) {
      if (cartItem.quantity == 1) {
        state = [
          ...state.sublist(0, index),
          ...state.sublist(index + 1)
        ];
      } else {
        state = [
          ...state.sublist(0, index),
          CartItem(
            product: cartItem.product,
            quantity: cartItem.quantity - 1,
          ),
          ...state.sublist(index + 1)
        ];
      }
      _saveCart(); // Save cart to Shared Preferences
    }
  }

  // Save cart to Shared Preferences
  Future<void> _saveCart() async {
    final cartStorage = ref.read(cartStorageProvider);
    await cartStorage.saveCart(state);
  }

  // Get total price of all items in cart
  double getTotalAmount() {
    return state.fold(0.0, (total, item) {
      return total + (item.product['price'] * item.quantity);
    });
  }
}
