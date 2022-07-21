import 'package:flutter/material.dart';
import 'package:nutrition/providers/auth.dart';
import 'package:provider/provider.dart';

import 'screens/nutrition_summary.dart';
import 'screens/nutrition_overview.dart';
import 'screens/nutrition_details.dart';
import 'providers/food_combos.dart';
import 'providers/food_generated.dart';
import 'providers/food_chosen.dart';
import './providers/auth.dart';
import 'screens/nutrition_selection.dart';
import 'screens/user_nutrition.dart';
import 'screens/edit_nutrition.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: FoodCombo(),
        ),
        ChangeNotifierProvider.value(
          value: Food(),
        ),
        ChangeNotifierProvider.value(
          value: Choice(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.grey,
              accentColor: Colors.orange[300],
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? NutritionOverviewScreen() : AuthScreen(),
            routes: {
              NutritionDetailScreen.routeName: (ctx) => NutritionDetailScreen(),
              NutritionSummaryScreen.routeName: (ctx) =>
                  NutritionSummaryScreen(),
              NutritionSelectionScreen.routeName: (ctx) =>
                  NutritionSelectionScreen(),
              UserNutritionScreen.routeName: (ctx) => UserNutritionScreen(),
              EditNutritionScreen.routeName: (ctx) => EditNutritionScreen(),
            }),
      ),
    );
  }
}
