import 'package:flutter/material.dart';
import 'package:ssl_pinning_plugin/ssl_pinning_plugin.dart';

class _PinSSL {
  String serverURL = '';
  HttpMethod httpMethod = HttpMethod.Get;
  Map<String, String> headerHttp = new Map();
  String allowedSHAFingerprint = '';
  int timeout = 0;
  SHA sha;
}

_PinSSL _data = new _PinSSL();
Future checkSSL(String requestURL, BuildContext context) async {
  bool checked = false;
  String _fingerprint =
      "65 CF C4 D4 75 D4 20 A7 38 3B 97 33 09 AD 34 A8 2C 54 61 DB";
  List<String> allowedShA1FingerprintList = [];
  allowedShA1FingerprintList.add(_fingerprint);
  try {
    await SslPinningPlugin.check(
      serverURL: requestURL,
      headerHttp: _data.headerHttp,
      httpMethod: HttpMethod.Get,
      sha: SHA.SHA1,
      allowedSHAFingerprints: allowedShA1FingerprintList,
      timeout: 60,
    ).then((value) {
      print(value);
      if (value == "CONNECTION_SECURE") {
        checked = true;
      } else if (value == "CONNECTION_NOT_SECURE") {
        checked = false;
      } else {
        checked = false;
      }
    });
    //print("başarılı");
    return checked;
  } catch (e) {
    print("başarısız SSL");
  }
}
