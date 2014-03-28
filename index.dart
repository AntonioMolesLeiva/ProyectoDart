import 'dart:html';

void reverseText(MouseEvent event) {
  print("hgola");
//  var text = querySelector("#sample_text_id").text;
//  var buffer = new StringBuffer();
//  for (int i = text.length - 1; i >= 0; i--) {
//    buffer.write(text[i]);
//  }
//  querySelector("#sample_text_id").text = buffer.toString();
}

void main() {
  querySelector("#blackjack")
      ..onClick.listen(reverseText);
}