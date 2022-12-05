import 'package:get/get.dart';

import '../global/global.dart';
import '../models/product_models.dart';

class ProductController extends GetxController {
  int totalProductPrice = 0;
  RxInt amount = 0.obs;
  get totalPrice {
    for (CartProduct cartProduct in Global.cartProducts) {
      totalProductPrice = totalProductPrice + cartProduct.price;
    }
    return totalProductPrice;
  }

  get removePrice {
    for (CartProduct cartProduct in Global.cartProducts) {
      totalProductPrice = totalProductPrice - cartProduct.price;
    }
    return totalProductPrice;
  }
}
