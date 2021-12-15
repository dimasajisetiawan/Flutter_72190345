import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_72190345/apiservices.dart';
import 'package:image_picker/image_picker.dart';

import '../model.dart';

final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

class AddMhs extends StatefulWidget {
  final String title;
  AddMhs({Key? key, required this.title }) : super(key : key);

  @override
  _AddMhsState createState() => new _AddMhsState(title);
}

class _AddMhsState extends State<AddMhs> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  final String title;
  _AddMhsState(this.title);
  bool _isLoading = false;
  Mahasiswa mhs = new Mahasiswa();
  // File _imagefile;

  // Future<void> _pickImage (ImageSource source) async {
  //   File selected = (await ImagePicker.pickImage(source: source)) as File;
  //
  //   setState(() {
  //     _imagefile = selected;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Form(
                key : _formstate,
                child: Column(
                  children: <Widget> [
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "NIM",
                        hintText: "NIM",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                      onSaved: (String? value){
                        this.mhs.nim = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nama",
                        hintText: "Nama Mahasiswa",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                      onSaved: (String? value){
                        this.mhs.nama = value;
                      },
                    ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    hintText: "Alamat Mahasiswa",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  onSaved: (String? value){
                    this.mhs.alamat = value;
                  },
                ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Email Mahasiswa",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                      onSaved: (String? value){
                        this.mhs.email = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // _imagefile == null ? Text("Silahkan Pilih Gambar Dahulu ") : Image.file(
                    //   _imagefile,
                    //   fit: BoxFit.cover,
                    //   height: 300.0,
                    //   alignment: Alignment.topCenter,
                    //   width: MediaQuery.of(context).size.width,
                    // ),
                    // MaterialButton(
                    //   minWidth: MediaQuery.of(context).size.width,
                    //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //   color: Colors.blue,
                    //   onPressed: () {
                    //     _pickImage(ImageSource.gallery);
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       new Icon(Icons.image, color: Colors.white,),
                    //       Text("Upload Foto",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        color: Colors.blue,
                        onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text("Simpan Data"),
                                content: Text("Apakah Mau Menyimpan data ini?"),
                                actions: <Widget> [
                                  TextButton(
                                      onPressed: () async{
                                        _formstate.currentState!.save();
                                        setState(() => _isLoading=true);
                                        this.mhs.nim_progmob = "721600012";
                                        // List<Int> imageBytes = _imagefile.readAsBytesSync();
                                        // this.mhs.foto = base64Encode(imageBytes);
                                        // ApiServices().createMhsWithFoto(this.mhs, _imagefile, _imagefile.path).then((isSuccess){
                                        ApiServices().createMhs(this.mhs).then((isSuccess) {
                                          setState(() => _isLoading = false);
                                          if(isSuccess){
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }else{
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        });

                                      },
                                      child: Text("Ya"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                    Navigator.pop(context);
                                  },
                                    child: Text("Tidak"),
                                  )
                                ],
                              );
                            },
                            );
                        },
                      child: Text("Simpan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                        ),
                  ],
                ),
              ),
              _isLoading
              ? Stack(
                children: <Widget>[
                  Opacity(
                      opacity: 0.3,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}



