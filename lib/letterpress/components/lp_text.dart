part of octane.letterpress.ds;

class LPText extends LPPostComponent {
  final String content;
  final LPFont lpFont;
  final bool isClickable;
  final bool isHeader;
  final TextAlign textAlign;
  final Map<String, dynamic> props = {};

  LPText({
    required this.content,
    required this.lpFont,
    required this.isClickable,
    required this.isHeader,
    this.textAlign = TextAlign.left,
    super.key,
  });

  LPText.header1({
    required this.content,
    this.textAlign = TextAlign.left,
  })  : lpFont = LPFont.header1(),
        isClickable = false,
        isHeader = true;

  LPText.header2({
    required this.content,
    this.textAlign = TextAlign.left,
  })  : lpFont = LPFont.header2(),
        isClickable = false,
        isHeader = true;

  LPText.header3({
    required this.content,
    this.textAlign = TextAlign.left,
  })  : lpFont = LPFont.header3(),
        isClickable = false,
        isHeader = true;

  LPText.plainBody({
    required this.content,
    this.textAlign = TextAlign.left,
    bool isItalic = false,
  })  : lpFont = isItalic ? LPFont.bodyItalic() : LPFont.body(),
        isClickable = false,
        isHeader = false;

  LPText.verse({
    required this.content,
    this.textAlign = TextAlign.center,
    bool isItalic = false,
  })  : lpFont = isItalic ? LPFont.verseQuoteItalic() : LPFont.verseQuote(),
        isClickable = false,
        isHeader = false;

  LPText.hyperlink({
    required this.content,
    this.textAlign = TextAlign.left,
    required String url,
  })  : lpFont = LPFont.hyperlink(),
        isClickable = true,
        isHeader = false {
    props.addAll({'url': url});
  }

  LPText.paragraphBreak()
      : content = '\n',
        lpFont = LPFont.body(),
        isClickable = false,
        textAlign = TextAlign.left,
        isHeader = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SelectableText(
        content,
        style: lpFont.textStyle,
        textAlign: textAlign,
      ),
    );
  }
}

class LPTextSpan extends LPPostComponent {
  final List<LPText> lpTextComponents;

  LPTextSpan({
    required this.lpTextComponents,
  });

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer? gestureRecog(LPText lpText) {
      if (lpText.isClickable) {
        return TapGestureRecognizer()
          ..onTap = () {
            window.open(lpText.props['url'], '');
          };
      } else {
        return null;
      }
    }

    return SelectableText.rich(
      TextSpan(
        children: List<TextSpan>.generate(
          lpTextComponents.length,
          (int i) => TextSpan(
            text: lpTextComponents[i].content,
            style: lpTextComponents[i].lpFont.textStyle,
            recognizer: gestureRecog(lpTextComponents[i]),
          ),
        ),
      ),
    );
  }
}
