import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_combos.dart';
import '../widgets/user_nutrition_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_nutrition.dart';

class UserNutritionScreen extends StatelessWidget {
  static const routeName = '/user-nutritions';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<FoodCombo>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<FoodCombo>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Schedules'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditNutritionScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserNutritionItem(
                  productsData.items[i].id,
                  productsData.items[i].title,
                  productsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
