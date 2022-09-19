import 'dart:convert';

import 'package:crypto/crypto.dart';

class ApiAccessController {
  static String publicApiKey = "440b5ad4cbfb6f0c4702746deb854cdb";
  static String privateApiKey = "5c099bd154a64619ec639132e3ab3faf9299c446";
}

var url = "http://gateway.marvel.com/v1/public/";
var timeStamp = DateTime.now();
var hash;

String generateUrl(String subject, {String additional = ""}) {
  generateHash();
  String urlFinal =
      "$url$subject?apikey=${ApiAccessController.publicApiKey}&hash=$hash&ts=${timeStamp.toIso8601String()}$additional";
  print(urlFinal);
  return urlFinal;
}

generateHash() {
  hash = generateMd5(
      timeStamp.toIso8601String() + ApiAccessController.privateApiKey + ApiAccessController.publicApiKey);
  print(hash);
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
