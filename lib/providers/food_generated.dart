import 'package:flutter/foundation.dart';

class FoodItem {
  final String id;
  final String title;
  final int quantity;
  final double rating;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.rating,
  });
}

class Food with ChangeNotifier {
  Map<String, FoodItem> _items = {};

  Map<String, FoodItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.rating;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => FoodItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          rating: existingCartItem.rating,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => FoodItem(
          id: DateTime.now().toString(),
          title: title,
          rating: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => FoodItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                rating: existingCartItem.rating,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
