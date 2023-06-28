import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key});

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
 Future _simpan() async {
    final respone = await http.post(
        Uri.parse("http://192.168.0.104/flutterapi/crudflutter/post.php"),
        body: {
          "nisn" :nisn.text,
          "nama" :nama.text,
          "alamat": alamat.text,
        }
        );
        if (respone.statusCode == 200) {
          return true;
        }  return false;
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data"),
      ),
      body: Form(
          key: formkey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextFormField(
                controller: nisn,
                decoration: const InputDecoration(
                    labelText: "Nisn",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0),),
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nisn tidak boleh kosong";
                      }
                    },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                    },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: alamat,
                decoration: const InputDecoration(
                    labelText: "alamat",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Alamat tidak boleh kosong";
                      }
                    },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _simpan().then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Data Berhasil Di Simpan")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal Simpan")));
                      }
                    });
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=>HomePage())), (route) => false);
                }
                },child: const Text("Simpan"),
              )
            ]),
          )),
    );
  }
}
