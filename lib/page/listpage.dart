import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_cruddemo/models/employee.dart';
import 'package:fl_cruddemo/page/addpage.dart';
import 'package:fl_cruddemo/page/editpage.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrudDemo.readkonsultasi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'List Of Pasien',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 31, 139, 153), // Warna AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddPage(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                    color: Colors.white, // Warna Background Card
                    elevation: 5.0, // memberikan efek bayangan pada card
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                               Color.fromARGB(255, 31, 139, 153), // Warna latar belakang ikon
                            child: Icon(Icons.person,
                                color: Colors.white), // Ikon "person"
                          ),
                          title: Text(
                            e["nama"],
                            style: TextStyle(
                              color: Colors.black, // Warna Text
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Container(
                            child: (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "NIM: " + e['nim'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "No Telphone: " + e['notelp'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Keluhan: " + e['keluhan'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            )),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5.0),
                                primary:
                                    const Color.fromARGB(255, 143, 133, 226),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text('Edit'),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) => EditPage(
                                      konsultasi: Konsultasi(
                                        uid: e.id,
                                        nama: e["nama"],
                                        nim: e["nim"],
                                        notelp: e["notelp"],
                                        keluhan: e["keluhan"],
                                      ),
                                    ),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5.0),
                                primary:
                                    const Color.fromARGB(255, 143, 133, 226),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text('Delete'),
                              onPressed: () async {
                                print(
                                    "Before deleting konsultasi with ID: ${e.id}");
                                var response =
                                    await FirebaseCrudDemo.deletekonsultasi(
                                        docId: e.id);
                                print(
                                    "After deleting konsultasi. Response: ${response.code}, ${response.message}");
                                if (response.code != 200) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                            "Error deleting konsultasi: ${response.message}"),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
