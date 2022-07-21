import 'package:flutter/material.dart';

import '../screens/nutrition_selection.dart';
import '../screens/user_nutrition.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: Icon(Icons.health_and_safety),
            title: Text('Welcome'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_hospital_outlined),
            title: Text('Clinic'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Schedules'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(NutritionSelectionScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Schedules'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserNutritionScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
