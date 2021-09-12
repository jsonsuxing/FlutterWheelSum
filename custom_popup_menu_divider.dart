import 'package:flutter/material.dart';

// ------------------------------------------------------
// author：AllenSu
// date  ：2021/7/19 12:30
// usage ：自定义 PopupMenuDivider 组件
// CSDN  ：https://blog.csdn.net/qq_42351033
// ------------------------------------------------------

const double _kMenuDividerHeight = 16.0;

class CustomPopupMenuDivider extends PopupMenuEntry<Null> {
  final double height;
  final Color color;

  const CustomPopupMenuDivider({
    this.height: _kMenuDividerHeight,
    this.color: Colors.white,
    Key key,
  }) : super(key: key);

  @override
  bool represents(void value) => false;

  @override
  _PopupMenuDividerState createState() => _PopupMenuDividerState();
}

class _PopupMenuDividerState extends State<CustomPopupMenuDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(height: widget.height, color: widget.color);
  }
}