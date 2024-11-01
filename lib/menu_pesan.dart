import 'package:flutter/material.dart';
import 'package:uts_ppb/menu.dart';
import 'package:uts_ppb/nota_page.dart';

//ignore: must_be_immutable
class PesanPage extends StatefulWidget {
  PesanPage({super.key, required this.pesananMenu});
  Menu pesananMenu;
  @override
  State<StatefulWidget> createState() => _PesanPage(pesananMenu: pesananMenu);
}

class _PesanPage extends State<PesanPage> {
  _PesanPage({required this.pesananMenu});
  Menu pesananMenu;
  int total = 0;
  int curJml = 0;
  TextEditingController jmlCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    jmlCtrl.text = '0';
  }

  void changeJml(String op) {
    curJml = int.tryParse(jmlCtrl.text.toString()) ?? 0;
    if (op == '+') {
      curJml++;
    } else if (op == '-' && curJml > 0) {
// Agar jumlah tidak menjadi negatif
      curJml--;
    }
    jmlCtrl.text = curJml.toString();
    setState(() {
      total = curJml * pesananMenu.harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pesanan Anda")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/${pesananMenu.gambar}',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              pesananMenu.Nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              pesananMenu.Deskripsi,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Rp. ${pesananMenu.harga}",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.pink,
                  ),
                  child: IconButton(
                    onPressed: () {
                      changeJml('-');
                    },
                    color: Colors.white,
                    icon: Icon(Icons.remove, size: 20),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: jmlCtrl,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.green,
                  ),
                  child: IconButton(
                    onPressed: () {
                      changeJml('+');
                    },
                    color: Colors.white,
                    icon: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Total: Rp. ${total.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotaPage(
                                  pesanan: pesananMenu, jumlah: curJml)));
                    },
                    child: const Text("Pesan Sekarang")))
          ],
        ),
      ),
    );
  }
}
