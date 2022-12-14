import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "asset/main_top.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "asset/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
            Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "asset/login_bottom.png",
              width: size.width * 0.30,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
