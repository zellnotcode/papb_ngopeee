import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:papb/komponen/batalmodal.dart';
import 'package:papb/payment/paymentbox.dart';
import 'package:papb/struk/struk.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentMenu extends StatefulWidget {
  final String totalPrice;

  const PaymentMenu({super.key, required this.totalPrice});

  @override
  State<PaymentMenu> createState() => _PaymentMenuState();
}

class _PaymentMenuState extends State<PaymentMenu> {
  final DateTime _timeAmbil = DateTime.now();

  postData() async {
    print('Test');
    var res = await http.post(
        Uri.parse(
            "http://103.187.146.72:3000/api/ngopeee/transaction/checkout"),
        body: {"totalPrice": "90000", "payment": "GOPAY"});
    if (res.statusCode == 200) {
      print('Success');
    } else {
      print('Error');
    }
  }

  launchDeepLinkGopay() async {
    try {
      launchUrl(Uri.parse(
          'https://simulator.sandbox.midtrans.com/gopay/partner/app/payment-pin?id=0f2fc10f-55b0-4f76-bd57-702238c3a2d1'));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            showBatalModal(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Pembayaran",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Outlet",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Ngopee Km. 10",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Metode Pembayaran",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PayBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Voucher",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ]),
          ),
          Container(
            width: 1000,
            height: 78,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color.fromARGB(255, 6, 209, 57),
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tidak ada Voucher',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tidak ada voucher tersedia',
                    style: GoogleFonts.plusJakartaSans(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Rp. " + widget.totalPrice,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
        ]),
      )),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 20,
        child: SizedBox(
          height: 96,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 153, 110, 56),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 140,
                  height: 52,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return StrukBelanja(
                          totalPrice: widget.totalPrice,
                          status: "Belum Lunas",
                        );
                      }));
                    },
                    child: const Center(
                      child: Text(
                        'Bayar Ditempat',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 110, 56),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 140,
                  height: 52,
                  child: GestureDetector(
                    onTap: () async {
                      await launchDeepLinkGopay();
                      Timer(Duration(minutes: 2), () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return StrukBelanja(
                            totalPrice: widget.totalPrice,
                            status: "Lunas",
                          );
                        }));
                      });
                    },
                    child: const Center(
                      child: Text(
                        'Bayar Sekarang',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
