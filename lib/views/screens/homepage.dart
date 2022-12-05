import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_system/utils/colors.dart';
import 'package:food_ordering_system/views/screens/favorite_product_page.dart';
import 'package:food_ordering_system/views/screens/product_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();

  GlobalKey<FormState> insertFormKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  ImagePicker imagePicker = ImagePicker();
  String productImage = '';

  Future imgFromGallery() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceImages = referenceRoot.child('images');
    Reference referenceImagesUpload = referenceImages.child(uniqueFileName);

    try {
      await referenceImagesUpload.putFile(File(file!.path));
      productImage = await referenceImagesUpload.getDownloadURL();
    } catch (error) {
      return null;
    }
  }

  String? name;
  int? price;
  double? rate;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StylishBottomBar(
        items: [
          AnimatedBarItems(
            icon: const Icon(
              Icons.home,
              size: 28,
            ),
            selectedIcon: const Icon(Icons.home),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Home'),
          ),
          AnimatedBarItems(
            icon: const Icon(
              Icons.message_sharp,
              size: 25,
            ),
            selectedIcon: const Icon(Icons.message_sharp),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Massage'),
          ),
          AnimatedBarItems(
            icon: const Icon(
              CupertinoIcons.bell_fill,
              size: 25,
            ),
            selectedIcon: const Icon(
              CupertinoIcons.bell_fill,
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Cart'),
          ),
          AnimatedBarItems(
            icon: const Icon(
              CupertinoIcons.heart,
              size: 25,
            ),
            selectedIcon: const Icon(
              CupertinoIcons.heart_fill,
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.lightGreenAccent,
            title: const Text('Like'),
          ),
        ],
        iconSize: 32,
        barAnimation: BarAnimation.transform3D,
        iconStyle: IconStyle.animated,
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        opacity: 0.3,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index!);
          setState(
            () {
              selected = index;
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/cart_page");
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text("Insert Records"),
          //       content: Form(
          //         key: insertFormKey,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             ElevatedButton(
          //               onPressed: () {
          //                 imgFromGallery();
          //               },
          //               child: Text("image"),
          //             ),
          //             TextFormField(
          //               decoration: const InputDecoration(
          //                 hintText: "Enter Name",
          //                 border: OutlineInputBorder(),
          //               ),
          //               controller: nameController,
          //               onSaved: (val) {
          //                 setState(() {
          //                   name = val;
          //                 });
          //               },
          //               validator: (val) =>
          //                   (val!.isEmpty) ? "Enter your name first" : null,
          //             ),
          //             const SizedBox(height: 10),
          //             TextFormField(
          //               decoration: const InputDecoration(
          //                 hintText: "Enter age",
          //                 border: OutlineInputBorder(),
          //               ),
          //               controller: priceController,
          //               onSaved: (val) {
          //                 setState(() {
          //                   price = int.parse(val!);
          //                 });
          //               },
          //               validator: (val) =>
          //                   (val!.isEmpty) ? "Enter your age first" : null,
          //             ),
          //             const SizedBox(height: 10),
          //             TextFormField(
          //               decoration: const InputDecoration(
          //                 hintText: "Enter city",
          //                 border: OutlineInputBorder(),
          //               ),
          //               controller: rateController,
          //               onSaved: (val) {
          //                 setState(() {
          //                   rate = double.parse(val!);
          //                 });
          //               },
          //               validator: (val) =>
          //                   (val!.isEmpty) ? "Enter your city first" : null,
          //             ),
          //           ],
          //         ),
          //       ),
          //       actions: [
          //         ElevatedButton(
          //           onPressed: () async {
          //             if (insertFormKey.currentState!.validate()) {
          //               insertFormKey.currentState!.save();
          //
          //               Map<String, dynamic> data = {
          //                 'name': name,
          //                 'productImage': productImage,
          //                 'price': price,
          //                 'rate': rate,
          //                 'isFav': false,
          //               };
          //               await CloudFirestoreHelper.cloudFirestoreHelper
          //                   .insertGroRecord(data: data);
          //
          //               nameController.clear();
          //               priceController.clear();
          //               rateController.clear();
          //
          //               setState(() {
          //                 name = null;
          //                 price = null;
          //                 rate = null;
          //               });
          //               Navigator.of(context).pop();
          //             }
          //           },
          //           child: Text("Insert"),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {
          //             nameController.clear();
          //             rateController.clear();
          //             priceController.clear();
          //             setState(() {
          //               name = null;
          //               rate = null;
          //               price = null;
          //             });
          //             Navigator.of(context).pop();
          //           },
          //           child: Text("Cancel"),
          //         ),
          //       ],
          //     );
          //   },
          // );
        },
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: const Icon(
          CupertinoIcons.cart_fill,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: const [
            ProductPage(),
            Center(
              child: Text('Star'),
            ),
            CartPage(),
            FavoritesPage(),
            // Center(child: Text("Cart")),
          ],
        ),
      ),
    );
  }
}
