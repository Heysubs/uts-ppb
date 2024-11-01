import 'package:flutter/material.dart';
import 'package:uts_ppb/update_user_screen.dart';
import 'package:uts_ppb/menu.dart'; // Pastikan file ini mendefinisikan kelas Menu
import 'package:uts_ppb/menu_pesan.dart'; // Pastikan file ini mendefinisikan kelas PesanPage

class MenuPage extends StatefulWidget {
  MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> listMenu = [];
  double totalHarga = 0.0;

  void dummyMenu() {
    listMenu.add(Menu(
        Nama: 'Ayam Krispi',
        Deskripsi: "Ayam Goreng dengan Kriuk Tanpa Batas",
        harga: 7000,
        gambar: 'Ayam-Krispi.jpg'));
    listMenu.add(Menu(
        Nama: "Ayam Bakar",
        Deskripsi: "Ayam Bakar Asli Kudus Pedes Manis",
        harga: 15000,
        gambar: 'Ayam-Bakar.jpg'));
    listMenu.add(Menu(
        Nama: "Ayam Goreng Kalasan",
        Deskripsi: "Ayam Goreng Enak dan Lezat Tanpa Bahan Kimia",
        harga: 15000,
        gambar: 'Ayam-Goreng.jpg'));
  }

  @override
  void initState() {
    super.initState();
    dummyMenu(); // Panggil hanya sekali saat widget dibuat pertama kali
  }

  void _updateTotal(double harga) {
    setState(() {
      totalHarga += harga;
    });
  }

  void _cancelTotal(double harga) {
    setState(() {
      totalHarga -= harga;
      if (totalHarga < 0)
        totalHarga = 0; // Mencegah nilai total menjadi negatif
    });
  }

  // Fungsi untuk menampilkan menu popup
  void _showPopupMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          Offset.zero,
          Offset.zero,
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'call_center',
          child: Text('Call Center'),
        ),
        PopupMenuItem<String>(
          value: 'sms_center',
          child: Text('SMS Center'),
        ),
        PopupMenuItem<String>(
          value: 'maps',
          child: Text('Lokasi/Maps'),
        ),
        PopupMenuItem<String>(
          value: 'update_user',
          child: Text('Update User & Password'),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle menu selection
      if (value != null) {
        switch (value) {
          case 'call_center':
            // Aksi untuk Call Center
            break;
          case 'sms_center':
            // Aksi untuk SMS Center
            break;
          case 'maps':
            // Aksi untuk Lokasi/Maps
            break;
          case 'update_user':
            // Aksi untuk Update User & Password
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UpdateUserScreen()), // Navigate to Update User Screen
            );
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Penjualan Ayamku'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showPopupMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Pilih Menu",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Tiga kolom
              crossAxisSpacing: 8, // Jarak antar kolom
              mainAxisSpacing: 8, // Jarak antar baris
              padding: const EdgeInsets.all(16.0),
              children: List.generate(listMenu.length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _updateTotal(listMenu[index].harga.toDouble());
                      },
                      onDoubleTap: () {
                        _cancelTotal(listMenu[index].harga.toDouble());
                      },
                      child: Image.asset(
                        'assets/images/${listMenu[index].gambar}',
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8), // Spasi antara gambar dan teks
                    Text(
                      listMenu[index].Nama,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      listMenu[index].Deskripsi,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rp. ${listMenu[index].harga}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8), // Spasi antara teks dan tombol
                    ElevatedButton(
                      child: const Text("Pesan"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PesanPage(pesananMenu: listMenu[index]),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
