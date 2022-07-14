import 'package:casino_test/src/utils/dimensions.dart';
import 'package:flutter/material.dart';

class DesignScaffold extends StatelessWidget {
  const DesignScaffold({
    Key? key,
    this.color = Colors.white,
    required this.body,
    this.horizontalPadding = 20,
    this.respectSafeArea = true,
    this.isScrollable = true,
  }) : super(key: key);

  final Widget body;
  final Color color;
  final double horizontalPadding;
  final bool respectSafeArea;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: isScrollable
            ? ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: screenWidth(context) * 0.05,
                ),
                children: [
                  body,
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: screenWidth(context) * 0.05,
                ),
                child: body,
              ),
      ),
    );
  }
}
