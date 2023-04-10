import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:papb/komponen/cardbutton.dart';
import 'package:papb/komponen/globalvariable.dart';
import 'package:papb/komponen/loginmodal.dart';
import 'package:papb/komponen/promomodal.dart';
import 'package:papb/payment/payment.dart';
import 'package:papb/tab_decider.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Map<String, dynamic>> promoMap = [
    {
      "judul": "Tidak ada Voucher",
      "berlaku": "Berlaku hingga Unlimit",
      "syarat": "Tidak ada Voucher Tersedia",
      "urlimage": "./assets/image/produk_c.JPG"
    }
  ];

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              // ignore: unnecessary_new
              new MaterialPageRoute(builder: (context) => const TabDecider()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Keranjang",
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
            child: Column(
              children: [
                CardButton(),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Pesanan',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     primary: const Color.fromARGB(255, 153, 110, 56),
                        //     textStyle: GoogleFonts.plusJakartaSans(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        //   onPressed: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) {
                        //       return const OrderPage();
                        //     }));
                        //   },
                        //   child: const Text('Tambah Pesanan'),
                        // ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            "${cart.elementAt(index)['image']}",
                                            width: 100,
                                            height: 94,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cart.elementAt(index)['nameMenu']}",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  "${cart.elementAt(index)['suhu']}",
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "•",
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "${cart.elementAt(index)['ukuran']}",
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "${cart.elementAt(index)['price']}",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cart.elementAt(index)['quantity']}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            cart.remove(cart.elementAt(index));
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Promo Voucher',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: promoMap.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showPilihModal(context);
                              },
                              child: Container(
                                width: 350.0,
                                height: 74.0,
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${promoMap.elementAt(index)['judul']}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${promoMap.elementAt(index)['syarat']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            )),
      ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2),
                    LayoutBuilder(builder: (context, constraints) {
                      int subTotal = 0;
                      cart.forEach((element) {
                        subTotal = subTotal + int.parse(element["price"]);
                      });
                      print(subTotal);
                      totalPrice = subTotal;
                      return Text(
                        "Rp. " + subTotal.toString(),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    }),
                    SizedBox(height: 8),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 153, 110, 56),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 140,
                  height: 52,
                  child: GestureDetector(
                    onTap: () {
                      if (totalPrice == 0) {
                        Fluttertoast.showToast(
                            msg: "Tambahkan Minuman Terlebih dahulu!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 102, 93, 68),
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return TabDecider();
                        }));
                      } else if (isLogin == false) {
                        showLoginModal(context);
                      } else {
                        // postData();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PaymentMenu(
                            totalPrice: totalPrice.toString(),
                          );
                        }));
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Beli Sekarang',
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
