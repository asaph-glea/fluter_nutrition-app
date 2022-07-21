import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'food_generated.dart';

class ChoiceItem {
  final String id;
  final double amount;
  final List<FoodItem> foods;
  final DateTime dateTime;

  ChoiceItem({
    @required this.id,
    @required this.amount,
    @required this.foods,
    @required this.dateTime,
  });
}

class Choice with ChangeNotifier {
  List<ChoiceItem> _orders = [];

  List<ChoiceItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://health-8dc4d-default-rtdb.firebaseio.com/choice.json');
    final response = await http.get(url);
    final List<ChoiceItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        ChoiceItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          foods: (orderData['products'] as List<dynamic>)
              .map(
                (item) => FoodItem(
                  id: item['id'],
                  rating: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<FoodItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://health-8dc4d-default-rtdb.firebaseio.com/choice.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.rating,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      ChoiceItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        foods: cartProducts,
      ),
    );
    notifyListeners();
  }
}
