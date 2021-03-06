import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_72190345/model.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiServices{
  final String baseUrl = "http://192.168.3.252/flutter-api/public";
  Client client = Client();

  // dashboard
  // mahasiswa
  Future<DashboardSI?> getDashboard() async{
    final response = await client.get(Uri.parse("$baseUrl/api/progmob/dashboard/721600012"));
    if(response.statusCode==200){
      return DashboardSI.fromJson(json.decode(response.body));
    }
    else{
      return null;
    }
  }
  
  //mahasiswa
  Future<List<Mahasiswa>?> getMahasiswa() async {
      final response = await client.get(Uri.parse("$baseUrl/api/progmob/mhs/721600012"));
        if(response.statusCode==200){
         return mahasiswaFromJson(response.body);
        }else{
          return null;
        }

  }

  // List<Mahasiswa> parseMhs(String responseBody ){
  //   final parsed = jsonDecode(responseBody).cast<Map<String, String>>();
  //   return parsed.map<Mahasiswa>((json) => Mahasiswa.fromJson(json)).toList();
  // }
  Future<bool> createMhs(Mahasiswa data) async {
    final response = await client.post(
        Uri.parse("$baseUrl/api/progmob/mhs/create"),
      headers: {"content-type" : "application/json"},
      body: mahasiswaToJson(data),
    );
    if(response.statusCode==200){
      return true;
    } else {
      return false;
    }
  }
  Future<bool> createMhsWithFoto(Mahasiswa data, File file, String filename) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/progmob/mhs/createwithfoto")
    );

    Map<String, String> headers={
      "Content-type" : "multipart/form-data"
    };

    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        "foto",
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename
      )
    );

    request.fields.addAll({
      "nama" : data.nama ?? "" as String,
      "nim" : data.nim ?? "" as String,
      "alamat" : data.alamat ?? "" as String,
      "email" : data.email ?? "" as String,
      "nim_progmob" : data.nim_progmob ?? "" as String
    });

    var response = await request.send();
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateMhsWithFoto(Mahasiswa data, File file, String nimcari) async {
    String isfotoupdate = "0";
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/progmob/mhs/updatewithfoto")
    );

    Map<String, String> headers={
      "Content-type" : "multipart/form-data"
    };

    request.headers.addAll(headers);

    if(file != null){
      request.files.add(
        http.MultipartFile(
          "foto",
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path
        )
      );
      isfotoupdate = "1";
    }

    request.fields.addAll({
      "nama" : data.nama ?? "" as String,
      "nim" : data.nim ?? "" as String,
      "alamat" : data.alamat ?? "" as String,
      "email" : data.email ?? "" as String,
      "nim_progmob" : data.nim_progmob ?? "" as String,
      "nim_cari" : nimcari,
      "is_foto_update" : isfotoupdate
    });

    var response = await request.send();
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateMhs(Mahasiswa data, String nimcari) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/api/progmob/mhs/update")
    );

    Map<String, String> headers={
      "Content-type" : "application/json"
    };

    request.headers.addAll(headers);


    request.fields.addAll({
      "nama" : data.nama ?? "" as String,
      "nim" : data.nim ?? "" as String,
      "alamat" : data.alamat ?? "" as String,
      "email" : data.email ?? "" as String,
      "nim_progmob" : data.nim_progmob ?? "" as String,
      "nim_cari" : nimcari
    });

    var response = await request.send();
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteMhs(String nim) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/progmob/mhs/delete"),
      headers: {"content-type" : "application/json"},
      body: jsonEncode(<String, String>{
        "nim" : nim,
        "nim_progmob" : "721600012"
      })
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

}