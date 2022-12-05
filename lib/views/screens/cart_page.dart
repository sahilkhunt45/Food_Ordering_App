import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../global/global.dart';
import '../../helpers/firebase_helper.dart';
import '../../models/product_models.dart';
import '../../utils/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ProductController productController = Get.put(ProductController());
  int? totalProduct;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: CloudFirestoreHelper.cloudFirestoreHelper.selectCartRecord(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: SelectableText("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? data = snapshot.data;
              List<QueryDocumentSnapshot> documents = data!.docs;
              Global.cartProducts = documents
                  .map((e) => CartProduct.fromMap(data: e))
                  .toList()
                  .obs;
              totalProduct = Global.cartProducts.length;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          margin:
                              const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                          width: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Cart Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(width: 135),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        children: [
                          const Divider(
                            color: primaryColor,
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Product",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "${Global.cartProducts.length} Qu.",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "${productController.totalPrice}.00\$",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  (Global.cartProducts.isNotEmpty)
                      ? Expanded(
                          flex: 12,
                          child: GridView.builder(
                            itemCount: Global.cartProducts.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 13,
                              mainAxisExtent: 270,
                              childAspectRatio: 0.10,
                            ),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed('/detail_page',
                                          arguments: Global.cartProducts[i]);
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
                                              onTap: () {},
                                              child:
                                                  (Global.cartProducts[i].isFav)
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
                                                image: NetworkImage(Global
                                                    .cartProducts[i]
                                                    .productImage),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              Global.cartProducts[i].name,
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
                                                "${Global.cartProducts[i].rate} ⭐",
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
                                                "\$ ${Global.cartProducts[i].price}.00",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    bottomRight:
                                                        Radius.circular(25),
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    Get.snackbar(
                                                      "Your item remove in cart successfully",
                                                      "",
                                                      showProgressIndicator:
                                                          true,
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
                                                    productController
                                                        .removePrice;
                                                    await CloudFirestoreHelper
                                                        .cloudFirestoreHelper
                                                        .deleteRecord(
                                                      id: documents[i].id,
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: colorWhite,
                                                  ),
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
                          flex: 12,
                          child: Icon(
                            Icons.remove_shopping_cart_sharp,
                            size: 80,
                          ),
                        ),
                ],
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.black,
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
