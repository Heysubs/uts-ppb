import 'package:flutter/material.dart';
import 'package:uts_ppb/menu.dart';
import 'package:uts_ppb/menu_page.dart';

//ignore: must_be_immutable
class NotaPage extends StatelessWidget {
  NotaPage({super.key, required this.pesanan, required this.jumlah});
  Menu pesanan;
  int jumlah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nota Anda")),
        body: Column(
          children: [
            Text("Pemesanan"),
            Text(pesanan.Nama),
            Text("${pesanan.harga} x ${jumlah}"),
            Text("Berhasil Disimpan"),
            Text("Total Bayar:"),
            Text((pesanan.harga * jumlah).toString()),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MenuPage()),
                      (Route<dynamic> r) => false);
                },
                child: Text("Kembali ke Menu"))
          ],
        ));
  }
}
