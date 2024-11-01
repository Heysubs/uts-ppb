import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', _newPasswordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password updated successfully!')),
    );
    Navigator.pop(context); // Kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
