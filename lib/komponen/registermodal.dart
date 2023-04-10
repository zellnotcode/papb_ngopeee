import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:papb/komponen/loginmodal.dart';
import 'package:http/http.dart' as http;

import '../tab_decider.dart';

void showRegistermodal(context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  goHome() {
    Navigator.pushReplacement(
      context,
      // ignore: unnecessary_new
      new MaterialPageRoute(builder: (context) => const TabDecider()),
    );
  }

  register() async {
    try {
      print("BEFORE RES");
      var res = await http.post(
          Uri.parse('http://103.187.146.72:3000/api/ngopeee/register'),
          headers: {
            "Accept": '*/*'
          },
          body: {
            "Username": "Unknown",
            "Password": passController.text,
            "noHp": "6281350199978",
            "email": emailController.text,
          });
      print("POST SUCCESS");
      print(res.body);
      if (res.statusCode != 409) {
        print("EMAIL EXIST");
        emailController.text = "";
        passController.text = "";
        Fluttertoast.showToast(
            msg: "Berhasil Daftar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Email sudah digunakan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 460,
          color: Color(0xFF737373),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  "Email",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'yourmail@mail.com',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Kata Sandi",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '********',
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan Email yang masih aktif",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Mendaftar berarti setuju semua syarat dan ketentuan!",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 110, 56),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 1000,
                  height: 48,
                  child: GestureDetector(
                    onTap: () {
                      register();
                    },
                    child: const Center(
                      child: Text('Daftar',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showLoginModal(context);
                      },
                      child: Text(
                        "Klik untuk masuk",
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color.fromARGB(255, 153, 110, 56),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
