import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  const AppCircleButton({
    super.key,
    required this.child,
    this.color,
    this.width = 60,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      child: InkWell(
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
