import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_system/views/allproduct/food.dart';
import 'package:food_ordering_system/views/allproduct/fruit.dart';
import 'package:food_ordering_system/views/allproduct/groceries.dart';
import 'package:food_ordering_system/views/allproduct/veges.dart';
import 'package:food_ordering_system/views/product_detailpage/food_detail_page.dart';
import 'package:food_ordering_system/views/screens/cart_page.dart';
import 'package:food_ordering_system/views/screens/favorite_product_page.dart';
import 'package:food_ordering_system/views/screens/homepage.dart';
import 'package:food_ordering_system/views/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/intro_page',
      getPages: <GetPage>[
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/intro_page', page: () => SplashScreenPage()),
        GetPage(name: '/product_page', page: () => FoodPage()),
        GetPage(name: '/cart_page', page: () => CartPage()),
        GetPage(name: '/fav_page', page: () => FavoritesPage()),
        GetPage(name: '/fruit_page', page: () => FruitPage()),
        GetPage(name: '/detail_page', page: () => ProductDetailPage()),
        GetPage(name: '/veges_page', page: () => VegesPage()),
        GetPage(name: '/groceries_page', page: () => GroceriesPage()),
      ],
    ),
  );
}
