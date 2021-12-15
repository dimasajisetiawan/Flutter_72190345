import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// charts
class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

//dashboard
class DashboardSI{
  String mahasiswa;
  String dosen;
  String matakuliah;
  String jadwal;

  DashboardSI({required this.mahasiswa, required this.dosen, required this.matakuliah, required this.jadwal});

  factory DashboardSI.fromJson(Map<String, dynamic> json ) {
    return DashboardSI(
        mahasiswa: json["mahasiswa"],
        dosen: json["dosen"],
        matakuliah: json["matakuliah"],
        jadwal: json["jadwal"]
    );
  }
}
//mahasiswa
class Mahasiswa {
  String? id;
  String? nama;
  String? nim;
  String? alamat;
  String? email;
  String? foto;
  String? nim_progmob;

  Mahasiswa(
      {this.id, this.nama,  this.nim,  this.alamat, this.email, this.foto,
        this.nim_progmob});

  factory Mahasiswa.fromJson(Map<String, dynamic> map){
    return Mahasiswa(
        id: map["id"] ?? "" as String ,
        nama: map["nama"] ?? "" as String,
        nim: map["nim"] ?? "" as String ,
        alamat: map["alamat"] ?? "" as String,
        email: map["email"] ?? "" as String,
        foto: map["foto"] ?? "" as String,
        nim_progmob: map["nim_progmob"] ?? "" as String );
  }

  Map<String, dynamic> toJson(){
    return {"id" : id, "nama" : nama, "nim" : nim, "alamat" : alamat, "email" : email, "foto" : foto, "nim_progmob" : nim_progmob};
  }

  @override
  String toString(){
    return 'Dosen{id: $id, nama: $nama, nim: $nim, alamat: $alamat, email: $email, foto: $foto, nim_progmob: $nim_progmob)';
  }
}

List<Mahasiswa> mahasiswaFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Mahasiswa>.from(data.map((item) => Mahasiswa.fromJson(item)));
}

String mahasiswaToJson(Mahasiswa data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

//matakuliah
class Matakuliah{
  String kodeMataKuliah;
  String hari;
  String sesi;
  String dosen;
  String nama;
  int jmlMhs;

  Matakuliah(this.kodeMataKuliah, this.hari, this.sesi, this.dosen, this.nama,
      this.jmlMhs);

}

//dosen
class Dosen{
  int id;
  String nama;
  String nidn;
  String alamat;
  String email;
  String gelar;
  String foto;
  String nim_progmob;

  Dosen({required this.id, required this.nama, required this.nidn, required this.alamat, required this.email, required this.gelar,
      required this.foto, required this.nim_progmob});

  factory Dosen.fromJson(Map<String, dynamic> map){
    return Dosen(id: map['id'], nama: map['nama'], nidn: map['nidn'], alamat: map['alamat'], email: map['email'], gelar: map['gelar'],
    foto: map['foto'], nim_progmob: map['nim_progmob']);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "nidn": nidn,
      "alamat": alamat,
      "email": email,
      "gelar": gelar,
      "foto": foto,
      "nim_progmob": nim_progmob
    };
  }

    @override
    String toString(){
      return 'Dosen{id : $id, nama:$nama, nidn:$nidn, alamat:$alamat, email:$email, gelar:$gelar, foto:$foto, nim_progmob:$nim_progmob}';
    }
  }

  List<Dosen> dosenFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Dosen>.from(data.map((item) => Dosen.fromJson(item)));
  }

  String dosenToJson(Dosen data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
  }






