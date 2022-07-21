import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_chosen.dart' show Choice;
import '../widgets/nutrition_select_item.dart';
import '../widgets/app_drawer.dart';

class NutritionSelectionScreen extends StatelessWidget {
  static const routeName = '/selection-screen';

  @override
  Widget build(BuildContext context) {
    print('building Schedule');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Schedule'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Choice>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Choice>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => SelectItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
