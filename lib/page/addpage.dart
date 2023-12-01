import 'package:fl_cruddemo/page/listpage.dart';
import 'package:flutter/material.dart';
import '../services/firebase_crud.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _konsultasi_nama = TextEditingController();
  final _konsultasi_nim = TextEditingController();
  final _konsultasi_notelp = TextEditingController();
  final _konsultasi_keluhan = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final namaField = TextFormField(
        controller: _konsultasi_nama,
        keyboardType: TextInputType.name,
        style: TextStyle (color: Colors.black,),
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: "Nama",
    hintStyle: TextStyle(color: Colors.grey), // Ganti dengan warna abu terang
    prefixIcon: Icon(Icons.person, color: Colors.grey), // Ganti dengan ikon yang sesuai
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

    final nimField = TextFormField(
        controller: _konsultasi_nim,
        keyboardType: TextInputType.name,
        style: TextStyle (color: Colors.black,),
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: "NIM",
    hintStyle: TextStyle(color: Colors.grey), // Ganti dengan warna abu terang
    prefixIcon: Icon(Icons.school, color: Colors.grey), // Ganti dengan ikon yang sesuai
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

    final notelpField = TextFormField(
        controller: _konsultasi_notelp,
        keyboardType: TextInputType.name,
        style: TextStyle (color: Colors.black,),
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: "No telphone",
    hintStyle: TextStyle(color: Colors.grey), // Ganti dengan warna abu terang
    prefixIcon: Icon(Icons.phone, color: Colors.grey), // Ganti dengan ikon yang sesuai
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

    final keluhanField = TextFormField(
        controller: _konsultasi_keluhan,
        keyboardType: TextInputType.name,
        style: TextStyle (color: const Color.fromARGB(255, 14, 13, 13),), // membuat input text menjadi warna hitam
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: "Keluhan",
    hintStyle: TextStyle(color: Colors.grey), // Ganti dengan warna abu terang
    prefixIcon: Icon(Icons.warning, color: Colors.grey), // Ganti dengan ikon yang sesuai
   border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan radius yang diinginkan
    borderSide: BorderSide(width: 20.0),
    ), // Sesuaikan dengan lebar border yang diinginkan
  ),
);

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('View List Of Pasien'));

    final SaveButon = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromARGB(255, 31, 139, 153),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrudDemo.addkonsultasi(
              nama: _konsultasi_nama.text,
              nim: _konsultasi_nim.text,
              notelp: _konsultasi_notelp.text,
              keluhan: _konsultasi_keluhan.text,
            );
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
       title: Text(
    'Konsultasi Kesehatan Mahasiswa',
    style: TextStyle(
      fontWeight: FontWeight.bold,
       color: Colors.white),
  ),
        backgroundColor: Color.fromARGB(255, 31, 139, 153),
        toolbarHeight: 100.0,
        elevation: 5.0,
      ),

      backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  namaField,
                  const SizedBox(height: 25.0),
                  nimField,
                  const SizedBox(height: 35.0),
                  notelpField,
                  const SizedBox(height: 45.0),
                  keluhanField,
                  const SizedBox(height: 60.0),
                  viewListbutton,
                  SaveButon,
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
