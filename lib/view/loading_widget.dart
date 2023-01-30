import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key, this.isLoading, required this.child});

  bool? isLoading;
  Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (isLoading == false) {
      return const Center(
        child: Text('Bir sorun oluştu tekrar dene'),
      );
    } else {
      return child;
    }
  }
}
