import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controler extends GetxController {
  var books = 1.obs;

  increment() {
    books.value++;
  }

  decrement() {
    if (books.value <= 1) {
      return;
    } else {
      books.value--;
    }
  }
}
