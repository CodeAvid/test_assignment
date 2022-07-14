import 'package:flutter/material.dart';

class DesignBackButton extends StatelessWidget {
  const DesignBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      child: BackButton(
        color: Colors.white,
      ),
    );
  }
}
