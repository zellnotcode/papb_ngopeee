import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:papb/home/main_page.dart';
import 'dart:convert';

import 'package:papb/komponen/globalvariable.dart';
import 'package:papb/komponen/registermodal.dart';
import 'package:papb/tab_decider.dart';

// import 'package:shared_preferences/shared_preferences.dart';
void showLoginModal(context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  login() async {
    try {
      var res = await http.post(
          Uri.parse('http://103.187.146.72:3000/api/ngopeee/login'),
          headers: {
            "Accept": '*/*'
          },
          body: {
            "email": emailController.text,
            "password": passController.text
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(res.body);
        // print((map['data']['Username']).toString());
        dataUser.add({
          'id': (map['data']['id']).toString(),
          'Username': (map['data']['Username']).toString(),
          'noHp': (map['data']['noHp']).toString(),
          'email': (map['data']['email']).toString(),
        });
        Fluttertoast.showToast(
            msg: "Berhasil Login",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print(dataUser);
        // SharedPreferences localStorage = await SharedPreferences.getInstance();
        // localStorage.setString('token', "asdasd");
        // localStorage.setString('user', json.encode(res.body['user']));
        Navigator.pushReplacement(
          context,
          // ignore: unnecessary_new
          new MaterialPageRoute(builder: (context) => const TabDecider()),
        );
        isLogin = true;
      } else {
        print("Login Gagal");
        Fluttertoast.showToast(
            msg: "Data Salah!",
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
          height: 360,
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
              child: Form(
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
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                    TextFormField(
                      controller: passController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '********',
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 153, 110, 56),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 1000,
                      height: 48,
                      child: InkWell(
                        onTap: () {
                          if (emailController.text != null &&
                              passController.text != null) {
                            login();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Data salah!')));
                          }
                        },
                        child: Center(
                          child: Text('Masuk',
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
                          "Belum punya akun?",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showRegistermodal(context);
                          },
                          child: Text(
                            "Klik untuk daftar",
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
              )),
        );
      });
}
