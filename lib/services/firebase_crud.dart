import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('konsultasi');

class FirebaseCrudDemo {
// Menambahkan dokumen Mahasiswa baru ke koleksi Firestore
  static Future<Response> addkonsultasi({
    required String nama,
    required String nim,
    required String notelp,
    required String keluhan,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();
    // Data yang akan ditambahkan ke Firestore
    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "nim": nim,
      "notelp": notelp,
      "keluhan": keluhan,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<Response> updatekonsultasi({
    required String nama,
    required String nim,
    required String notelp,
    required String keluhan,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "nim": nim,
      "notelp": notelp,
      "keluhan": keluhan,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Stream<QuerySnapshot> readkonsultasi() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deletekonsultasi({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Berhasil Menghapus Data Pasien";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }
}
