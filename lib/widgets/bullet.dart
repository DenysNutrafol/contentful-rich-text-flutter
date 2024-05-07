import 'package:flutter/material.dart';

class Bullet extends Text {
  const Bullet({
    String? bullet,
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          bullet ?? '•',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
