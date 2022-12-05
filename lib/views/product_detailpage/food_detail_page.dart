import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_system/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../../helpers/firebase_helper.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.3),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: primaryColor,
                          size: 25,
                        ),
                        Text(
                          "Food Details   ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: (res.isFav)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              //White Container
              Positioned(
                top: 260,
                left: 0,
                right: 0,
                child: Container(
                  height: 450,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              res.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 29),
                            ),
                            Container(
                              height: 50,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (productController.amount > 0) {
                                        productController.amount--;
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: colorWhite,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      "${productController.amount}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: colorWhite,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      productController.amount++;
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$${res.price}.00",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: primaryColor),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.orangeAccent,
                                  size: 27,
                                ),
                                Text(
                                  "${res.rate}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.water_drop_rounded,
                                  color: Colors.red,
                                  size: 27,
                                ),
                                Text(
                                  " 100 Kcal",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.orangeAccent,
                                  size: 27,
                                ),
                                Text(
                                  " 20min",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "About res  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 29),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              Map<String, dynamic> cartData = {
                                'name': res.name,
                                'productImage': res.productImage,
                                'price': res.price,
                                'rate': res.rate,
                                'isFav': res.isFav,
                              };

                              await CloudFirestoreHelper.cloudFirestoreHelper
                                  .insertCartRecord(cartData: cartData);
                              Get.snackbar(
                                "Your item add in cart successfully",
                                "",
                                showProgressIndicator: true,
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  size: 30,
                                ),
                                snackStyle: SnackStyle.FLOATING,
                                colorText: Colors.black,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.easeInOutBack,
                                leftBarIndicatorColor: Colors.black,
                                progressIndicatorBackgroundColor: Colors.black,
                                shouldIconPulse: true,
                                mainButton: TextButton(
                                  onPressed: () {},
                                  child: const Text("Dismiss"),
                                ),
                              );
                            },
                            child: Ink(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Container(
                  height: 250,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(res.productImage),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    productController.amount = 0.obs;
  }
}
