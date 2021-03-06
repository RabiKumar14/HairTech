import 'package:Beautech/admin/dev_adminside/add_product.dart';
import 'package:Beautech/models/appointment.dart';
import 'package:Beautech/models/order.dart';
import 'package:Beautech/models/product.dart';
import 'package:Beautech/models/salon.dart';
import 'package:Beautech/models/user.dart';
import 'package:Beautech/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  Future editProduct(Product oldProduct, Product updatedProduct) async {
    await ProductCollection()
        .collection
        .doc(oldProduct.documentId)
        .update(updatedProduct.toMap());
  }

  Future addNewUser(String id, AppUser newAppUser) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .set(newAppUser.toMap(), SetOptions(merge: true));
  }


  Future updateUserName(String id, String newAppUser) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .update({
      'appUserName': newAppUser
    });
  }
  Stream<AppUser> userData(String uid) {
    return FirebaseFirestore.instance.doc('user/$uid').snapshots().map((doc) {
      return AppUser.fromDocument(doc);
    });
  }

  Future addNewOrder(ProductOrder order) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .add(order.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('orders').doc(value.id).update(
        {'orderId': value.id},
      );
    });
  }

  Future editSalon(Salon oldSalon, Salon updatedSalon) async {
    await SalonCollection()
        .collection
        .doc(oldSalon.salonID)
        .update(updatedSalon.toMap());
  }

  Future addNewAppointment(Appointment appointment) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .add(appointment.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(value.id)
          .update(
        {'appointmentID': value.id},
      );
    });
  }

  Future addNewSalon(Salon salon) async {
    await FirebaseFirestore.instance
        .collection('salons')
        .add(salon.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('salons').doc(value.id).update(
        {'salonID': value.id},
      );
    });
  }

  Future addNewProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('products').doc(value.id).update(
        {'documentId': value.id},
      );
    });
  }

  Future updateService(List<SalonServices> salonService, String salonID) async {
    var services = [];
    salonService.forEach((element) {
      services.add(element.toMap());
    });
    await FirebaseFirestore.instance.collection("salons").doc(salonID).update({
      'salonServices': services,
    });
  }

  Future updateAppointment(String statusChange, String appointmentID) async {
    await FirebaseFirestore.instance
        .collection("appointments")
        .doc(appointmentID)
        .update({
      'appointmentStatus': statusChange,
    });
  }

    Future updateOrder(String statusChange, String orderID) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderID)
        .update({
      'status': statusChange,
    });
  }


  Future updateOutlet(List<SalonOutlets> salonOutlets, String salonID) async {
    var outlets = [];
    salonOutlets.forEach((element) {
      outlets.add(element.toMap());
    });
    await FirebaseFirestore.instance.collection("salons").doc(salonID).update({
      'salonOutlets': outlets,
    });
  }

  Future updateServiceStatus(
      List<SalonServices> salonService, String salonID) async {
    var services = [];

    salonService.forEach((element) {
      services.add(element.toMap());
    });
    await FirebaseFirestore.instance.collection("salons").doc(salonID).update({
      'salonServices': services,
    });
  }

  Stream<AppUser> streamAppUser(String id) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .snapshots()
        .map((event) => AppUser.fromMap(event.data()));
  }

  Future updateAddress(String id, String address) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .set({"appUserAddress": address}, SetOptions(merge: true));
  }
}
