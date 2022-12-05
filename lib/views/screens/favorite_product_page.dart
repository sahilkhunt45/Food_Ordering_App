import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_system/models/product_models.dart';
import 'package:get/get.dart';

import '../../controllers/favorite_controller.dart';
import '../../helpers/firebase_helper.dart';
import '../../utils/colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: CloudFirestoreHelper.cloudFirestoreHelper.selectFavRecord(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: SelectableText("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? data = snapshot.data;
              List<QueryDocumentSnapshot> documents = data!.docs;
              List<FavoriteProduct> favoriteProducts = documents
                  .map((e) => FavoriteProduct.fromMap(data: e))
                  .toList();
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Favorites Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: primaryColor,
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                  ),
                  (favoriteProducts.isNotEmpty)
                      ? Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 13,
                              mainAxisExtent: 270,
                              childAspectRatio: 0.10,
                            ),
                            itemCount: favoriteProducts.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed('/detail_page',
                                          arguments: favoriteProducts[i]);
                                    },
                                    child: Container(
                                      height: height * 0.2958,
                                      width: width * 45,
                                      decoration: BoxDecoration(
                                        color: colorWhite,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            offset: const Offset(0, 0),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                Get.snackbar(
                                                  "Your item remove in favorites successfully",
                                                  "",
                                                  showProgressIndicator: true,
                                                  icon: const Icon(
                                                    Icons.add_shopping_cart,
                                                    size: 30,
                                                  ),
                                                  snackStyle:
                                                      SnackStyle.FLOATING,
                                                  colorText: primaryColor,
                                                  dismissDirection:
                                                      DismissDirection
                                                          .horizontal,
                                                  forwardAnimationCurve:
                                                      Curves.easeInOutBack,
                                                  leftBarIndicatorColor:
                                                      Colors.green,
                                                  progressIndicatorBackgroundColor:
                                                      Colors.green,
                                                  shouldIconPulse: true,
                                                  mainButton: TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                          "Dismiss")),
                                                );
                                                await CloudFirestoreHelper
                                                    .cloudFirestoreHelper
                                                    .deleteFavProduct(
                                                        favId: documents[i].id);
                                              },
                                              child: (favoriteProducts[i].isFav)
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.grey,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            height: 140,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    favoriteProducts[i]
                                                        .productImage),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              favoriteProducts[i].name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 10),
                                              const Text(
                                                "20 min",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "${favoriteProducts[i].rate} ⭐",
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                          const SizedBox(height: 1),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 10),
                                              Text(
                                                "\$ ${favoriteProducts[i].price}.00",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : const Expanded(
                          child: Icon(Icons.hourglass_empty, size: 100),
                        ),
                ],
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.deepPurple,
                  radius: 50,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
