import 'dart:developer';

import 'package:apiwithriverpod/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:apiwithriverpod/service/service.dart';

class Controller extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  bool? isLoading;

  List<Datum> users = [];
  List<Datum> saved = [];

  void getData() {
    Service.fetch().then(
      (value) {
        if (value != null) {
          users = value.data;
          isLoading = true;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  void addSaved(Datum model) {
    saved.add(model);
    users.remove(model);
    notifyListeners();
  }

  notSavedButton() {
    pageController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInExpo);
  }

  savedButton() {
    pageController.animateTo(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInExpo);
  }
}
