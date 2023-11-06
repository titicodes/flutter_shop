import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const FNAME = "first_name";
  static const LNAME = "last_name";
  static const EMAIL = "email";
  static const CART = "cart";

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  List<CartItemModel>? cart;

  UserModel({this.id, this.firstName, this.email, this.cart, this.lastName});
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data != null) {
      firstName = data[FNAME] as String?;
      lastName = data[LNAME] as String?;
      email = data[EMAIL] as String?;
      id = data[ID] as String?;
      cart = _convertCartItems(data[CART] as List<dynamic>);
    }
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.length > 0) {
      cartFomDb.forEach((element) {
        _result.add(CartItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
}
