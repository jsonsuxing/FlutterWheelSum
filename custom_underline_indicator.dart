import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ------------------------------------------------------
// author：AllenSu
// date  ：2021/4/18 11:23 AM
// usage ：自定义 UnderlineTabIndicator
// CSDN  ：https://blog.csdn.net/qq_42351033
// ------------------------------------------------------

class CustomUnderlineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  final StrokeCap strokeCap; // 控制器的边角形状
  final double width; // 控制器的宽度

  const CustomUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.strokeCap: StrokeCap.square,
    this.width: 20,
  })  : assert(borderSide != null),
        assert(insets != null);

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is CustomUnderlineTabIndicator) {
      return CustomUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is CustomUnderlineTabIndicator) {
      return CustomUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    // 希望的宽度
    double wantWidth = this.width;
    // 取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    // 这里是核心代码
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final CustomUnderlineTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = decoration.strokeCap; // 这里修改控制器边角的形状
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
