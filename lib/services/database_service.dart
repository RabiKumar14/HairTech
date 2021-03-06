import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Beautech/models/appointment.dart';
import 'package:Beautech/models/category.dart';
import 'package:Beautech/models/order.dart';
import 'package:Beautech/models/product.dart';
import 'package:Beautech/models/salon.dart';

Stream<List<Product>> products() {
  return ProductCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
  });
}

Stream<List<ProductCategory>> categories() {
  return CategoriesCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => ProductCategory.fromDocument(doc))
        .toList();
  });
}

Stream<List<ProductOrder>> order() {
  return OrderCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => ProductOrder.fromDocument(doc)).toList();
  });
}

Stream<List<Appointment>> appointment() {
  return AppointmentCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Appointment.fromDocument(doc)).toList();
  });
}



Stream<List<Salon>> salon() {
  return SalonCollection().collection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Salon.fromDocument(doc)).toList();
  });
}

class ProductCollection {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('products');
}

class OrderCollection {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('orders');
}

class SalonCollection {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('salons');
}

class AppointmentCollection {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('appointments');
}

class CategoriesCollection {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('categories');
}
