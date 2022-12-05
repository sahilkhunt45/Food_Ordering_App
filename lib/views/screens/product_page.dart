import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../allproduct/food.dart';
import '../allproduct/fruit.dart';
import '../allproduct/groceries.dart';
import '../allproduct/veges.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController tabController;

  String search = "";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
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
                        " Surat,GJ.",
                        style: TextStyle(color: blackShade4, fontSize: 19),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/man.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hi Sahil",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Find your food",
                style: TextStyle(
                    color: blackShade1,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.done,
                onSaved: (val) {
                  setState(() {
                    search = val!;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Some value";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  border: InputBorder.none,
                  hintText: "Search Food",
                  hintStyle: const TextStyle(fontSize: 18),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  suffixIcon: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.slider_horizontal_3,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                labelColor: primaryColor,
                labelPadding: const EdgeInsets.only(right: 0),
                labelStyle: const TextStyle(fontSize: 20),
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                indicatorColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Foods"),
                  Tab(text: "Fruits"),
                  Tab(text: "Veges"),
                  Tab(text: "Groceries"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    FoodPage(),
                    FruitPage(),
                    VegesPage(),
                    GroceriesPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
