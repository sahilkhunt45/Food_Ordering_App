import 'package:get/get.dart';

import '../helpers/firebase_helper.dart';
import '../models/product_models.dart';

class FavoriteController extends GetxController {
  void addOrRemoveFavorite({required Food food, required String id}) {
    if (food.isFav) {
      CloudFirestoreHelper.cloudFirestoreHelper.removeInFavorite(favFoodId: id);
    } else {
      Map<String, dynamic> data = {
        'name': food.name,
        'price': food.price,
        'rate': food.rate,
        'isFav': true,
        'productImage': food.productImage,
      };
      CloudFirestoreHelper.cloudFirestoreHelper
          .insertFavRecord(favData: data, favFoodId: id);
    }
  }

  void addOrRemoveFruitFavorite({required Fruit fruit, required String id}) {
    if (fruit.isFav) {
      CloudFirestoreHelper.cloudFirestoreHelper
          .removeFruitInFavorite(favFruitId: id);
    } else {
      Map<String, dynamic> data = {
        'name': fruit.name,
        'price': fruit.price,
        'rate': fruit.rate,
        'isFav': true,
        'productImage': fruit.productImage,
      };
      CloudFirestoreHelper.cloudFirestoreHelper
          .insertFavFruitRecord(favData: data, favFruitId: id);
    }
  }

  void addOrRemoveVegesFavorite({required Veg veg, required String id}) {
    if (veg.isFav) {
      CloudFirestoreHelper.cloudFirestoreHelper
          .removeVegesInFavorite(favVegesId: id);
    } else {
      Map<String, dynamic> data = {
        'name': veg.name,
        'price': veg.price,
        'rate': veg.rate,
        'isFav': true,
        'productImage': veg.productImage,
      };
      CloudFirestoreHelper.cloudFirestoreHelper
          .insertFavVegesRecord(favData: data, favVegesId: id);
    }
  }

  void addOrRemoveGroFavorite({required Gro gro, required String id}) {
    if (gro.isFav) {
      CloudFirestoreHelper.cloudFirestoreHelper
          .removeGroInFavorite(favGroId: id);
    } else {
      Map<String, dynamic> data = {
        'name': gro.name,
        'price': gro.price,
        'rate': gro.rate,
        'isFav': true,
        'productImage': gro.productImage,
      };
      CloudFirestoreHelper.cloudFirestoreHelper
          .insertFavGroRecord(favData: data, favGroId: id);
    }
  }
}
