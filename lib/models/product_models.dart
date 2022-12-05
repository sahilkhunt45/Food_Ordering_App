class Food {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  Food({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });

  factory Food.fromMap({required data}) {
    return Food(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}

class Fruit {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  Fruit({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });
  factory Fruit.fromMap({required data}) {
    return Fruit(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}

class Veg {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  Veg({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });
  factory Veg.fromMap({required data}) {
    return Veg(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}

class Gro {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  Gro({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });
  factory Gro.fromMap({required data}) {
    return Gro(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}

class CartProduct {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  CartProduct({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });

  factory CartProduct.fromMap({required data}) {
    return CartProduct(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}

class FavoriteProduct {
  String name;
  int price;
  String productImage;
  double rate;
  bool isFav;

  FavoriteProduct({
    required this.name,
    required this.price,
    required this.productImage,
    required this.rate,
    required this.isFav,
  });

  factory FavoriteProduct.fromMap({required data}) {
    return FavoriteProduct(
      name: data['name'],
      price: data['price'],
      rate: data['rate'],
      productImage: data['productImage'],
      isFav: data['isFav'],
    );
  }
}
