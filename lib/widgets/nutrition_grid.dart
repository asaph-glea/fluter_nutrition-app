import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_combos.dart';
import 'nutrition_item.dart';

class NutritionsGrid extends StatelessWidget {
  final bool showFavs;

  NutritionsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<FoodCombo>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: NutritionItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
