import 'package:collection/collection.dart' show IterableExtension;
import 'package:contentful_rich_text/types/types.dart';
import 'package:flutter/material.dart';

/// Map of all Contentful marks
class MARKS {
  const MARKS._internal(this._key, this._value);
  final String _key;
  final String _value;

  @override
  String toString() => 'MARKS.$_key';
  String get key => _key;
  String get value => _value;

  operator [](dynamic index) {
    if (index is int) {
      return index <= items.length ? items[index] : null;
    }

    if (index is String) {
      return items.firstWhereOrNull((item) => item.key == index);
    }
    return null;
  }

  static const BOLD = const MARKS._internal('BOLD', 'bold');
  static const ITALIC = const MARKS._internal('ITALIC', 'italic');
  static const UNDERLINE = const MARKS._internal('UNDERLINE', 'underline');
  static const SUPERSCRIPT = const MARKS._internal('SUPERSCRIPT', 'superscript');
  static const SUBSCRIPT = const MARKS._internal('SUBSCRIPT', 'subscript');

  // Helpers
  static List<MARKS> get items => [
        BOLD,
        ITALIC,
        UNDERLINE,
        SUPERSCRIPT,
        SUBSCRIPT,
      ];
  static MARKS? fromKey(String key) =>
      items.firstWhereOrNull((item) => item.key == key);

  static MARKS? fromValue(String value) =>
      items.firstWhereOrNull((item) => item.value == value);

  // Can only be used to apply styling, does not return a TextSpan
  static RenderMark defaultMarkRenderers = RenderMark({
    MARKS.BOLD.value: TextStyle(fontWeight: FontWeight.bold),
    MARKS.ITALIC.value: TextStyle(fontStyle: FontStyle.italic),
    MARKS.UNDERLINE.value: TextStyle(decoration: TextDecoration.underline),
    MARKS.SUPERSCRIPT.value: TextStyle(fontFeatures: [FontFeature.superscripts()]),
    MARKS.SUBSCRIPT.value: TextStyle(fontFeatures: [FontFeature.subscripts()]),
  });

  static TextStyle getMarksTextStyles(
    List<Mark> marks,
    Map<dynamic, TextStyle> renderMark,
    TextStyle defaultStyle,
  ) {
    Map<String, TextStyle?> textStyles = {};
    for (var mark in marks) {
      textStyles.putIfAbsent(mark.type, () => renderMark[mark.type]);
    }
    final boldTextStyle = textStyles['bold'];
    final fontWeight = boldTextStyle?.fontWeight;

    final italicTextStyle = textStyles['italic'];
    final fontStyle = italicTextStyle?.fontStyle;

    final superscriptTextStyle = textStyles['superscript'];
    final subscriptTextStyle = textStyles['subscript'];

    Color? color;
    double? fontSize;
    String? fontFamily;
    List<FontFeature>? fontFeatures;

    if (boldTextStyle != null) {
      color = boldTextStyle.color ?? color;
      fontSize = boldTextStyle.fontSize ?? fontSize;
      fontFamily = boldTextStyle.fontFamily ?? fontFamily;
    }
    if (italicTextStyle != null) {
      color = italicTextStyle.color ?? color;
      fontSize = italicTextStyle.fontSize ?? fontSize;
      fontFamily = italicTextStyle.fontFamily ?? fontFamily;
    }
    if (subscriptTextStyle != null) {
      fontFeatures = subscriptTextStyle.fontFeatures;
    }
    if (superscriptTextStyle != null) {
      fontFeatures = superscriptTextStyle.fontFeatures;
    }

    return defaultStyle.copyWith(
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontFeatures: fontFeatures,
      decoration: textStyles['underline']?.decoration,
    );
  }

  static Map<dynamic, TextStyle> renderMarks(
          Map<dynamic, TextStyle>? optionRenderMarks) =>
      optionRenderMarks == null
          ? Map.from(MARKS.defaultMarkRenderers.renderMarks)
          : (Map.from(MARKS.defaultMarkRenderers.renderMarks)
            ..addAll(optionRenderMarks));
}
