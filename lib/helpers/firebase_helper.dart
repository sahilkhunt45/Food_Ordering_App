import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();

  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //----------------------------Food-----------------------------------------------------
  late CollectionReference productsRef;
  void connectWithProductCollection() {
    productsRef = firebaseFirestore.collection('food');
  }

  Stream<QuerySnapshot> selectRecord() {
    connectWithProductCollection();
    return productsRef.snapshots();
  }

  //----------------------------Fruit-----------------------------------------------------
  late CollectionReference fruitRef;
  void connectWithFruitCollection() {
    fruitRef = firebaseFirestore.collection('fruit');
  }

  Stream<QuerySnapshot> selectFruitRecord() {
    connectWithFruitCollection();
    return fruitRef.snapshots();
  }

  //----------------------------Groceries-----------------------------------------------------
  late CollectionReference vegRef;
  void connectWithVegCollection() {
    vegRef = firebaseFirestore.collection('vegetable');
  }

  Stream<QuerySnapshot> selectVegesRecord() {
    connectWithVegCollection();
    return vegRef.snapshots();
  }

  //----------------------------vegetables-----------------------------------------------------
  late CollectionReference groRef;
  void connectWithGroCollection() {
    groRef = firebaseFirestore.collection('groceries');
  }

  Stream<QuerySnapshot> selectGroRecord() {
    connectWithGroCollection();
    return groRef.snapshots();
  }

//-------------------------------CartDatabase--------------------------------------------------
  late CollectionReference productsCartRef;
  void connectWithCartCollection() {
    productsCartRef = firebaseFirestore.collection('cart');
  }

  Future<void> insertCartRecord(
      {required Map<String, dynamic> cartData}) async {
    connectWithCartCollection();
    await productsCartRef.add(cartData);
  }

  Stream<QuerySnapshot> selectCartRecord() {
    connectWithCartCollection();

    return productsCartRef.snapshots();
  }

  Future<void> deleteRecord({required String id}) async {
    connectWithCartCollection();
    await productsCartRef.doc(id).delete();
  }

////-------------------------------FavoriteDatabase--------------------------------------------------
  late CollectionReference productsFavRef;
  void connectWithFavCollection() {
    productsFavRef = firebaseFirestore.collection('fav');
  }

  Future<void> insertFavRecord(
      {required Map<String, dynamic> favData,
      required String favFoodId}) async {
    connectWithFavCollection();
    await productsFavRef.doc(favFoodId).set(favData);
    await productsRef.doc(favFoodId).update({
      'isFav': true,
    });
  }

  Future<void> insertFavFruitRecord(
      {required Map<String, dynamic> favData,
      required String favFruitId}) async {
    connectWithFavCollection();
    await productsFavRef.doc(favFruitId).set(favData);
    await fruitRef.doc(favFruitId).update({
      'isFav': true,
    });
  }

  Future<void> insertFavVegesRecord(
      {required Map<String, dynamic> favData,
      required String favVegesId}) async {
    connectWithFavCollection();
    await productsFavRef.doc(favVegesId).set(favData);
    await vegRef.doc(favVegesId).update({
      'isFav': true,
    });
  }

  Future<void> insertFavGroRecord(
      {required Map<String, dynamic> favData, required String favGroId}) async {
    connectWithFavCollection();
    await productsFavRef.doc(favGroId).set(favData);
    await groRef.doc(favGroId).update({
      'isFav': true,
    });
  }

  Stream<QuerySnapshot> selectFavRecord() {
    connectWithFavCollection();
    return productsFavRef.snapshots();
  }

  Future<void> deleteFavProduct({required String favId}) async {
    connectWithFavCollection();
    await productsFavRef.doc(favId).delete();
    await productsRef.doc(favId).update({
      'isFav': false,
    });
  }

  removeInFavorite({required String favFoodId}) async {
    connectWithFavCollection();
    connectWithProductCollection();
    await productsFavRef.doc(favFoodId).delete();
    await productsRef.doc(favFoodId).update({
      'isFav': false,
    });
  }

  removeFruitInFavorite({required String favFruitId}) async {
    connectWithFavCollection();
    connectWithFruitCollection();
    await productsFavRef.doc(favFruitId).delete();
    await fruitRef.doc(favFruitId).update({
      'isFav': false,
    });
  }

  removeVegesInFavorite({required String favVegesId}) async {
    connectWithFavCollection();
    connectWithVegCollection();
    await productsFavRef.doc(favVegesId).delete();
    await vegRef.doc(favVegesId).update({
      'isFav': false,
    });
  }

  removeGroInFavorite({required String favGroId}) async {
    connectWithFavCollection();
    connectWithGroCollection();
    await productsFavRef.doc(favGroId).delete();
    await groRef.doc(favGroId).update({
      'isFav': false,
    });
  }
}
