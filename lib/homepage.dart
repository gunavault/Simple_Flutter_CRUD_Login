import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/tambahdata.dart';
import 'package:flutter_crud/editdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.0.104/flutterapi/crudflutter/conn.php"),
          headers: {"Access-Control-Allow-Origin": "*"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _deletedata(String id) async {
    try {
      final response = await http.post(
          Uri.parse("http://192.168.0.104/flutterapi/crudflutter/delete.php"),
          body: {"nisn": id},
          headers: {"Access-Control-Allow-Origin": "*"});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: ListView.builder(
            itemCount: _listdata.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => EditDataPage(
                              ListData: {
                                "id": _listdata[index]['id'],
                                "nisn": _listdata[index]['nisn'],
                                "nama": _listdata[index]['nama'],
                                "alamat": _listdata[index]['alamat'],
                              },
                            )),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(_listdata[index]['nama']),
                    subtitle: Text(_listdata[index]['alamat']),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                  content: Text(
                                      "Yakin ingin menghapus data ${_listdata[index]['nama']}?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          _deletedata(_listdata[index]['nisn'])
                                              .then((value) {
                                            if (value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Data Berhasil Di hapus")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Gagal hapus data")));
                                            }
                                          });
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=>HomePage())), (route) => false);
                                        },
                                        child: Text("Ya")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Tidak")),
                                  ]);
                            }));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TambahData()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
