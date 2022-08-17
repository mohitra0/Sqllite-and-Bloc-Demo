import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manektech/utils/const.dart';

class ApiCallNew {
  Dio dio = Dio();
  Options opt = Options(headers: {
    "authorization": "Bearer ${AppConstant.authToken}",
  }, contentType: "application/x-www-form-urlencoded");

  String url;
  ApiCallNew(
    this.url,
  );
  hitApi() async {
    try {
      var response = await dio.post(
        url,
        options: opt,
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.data);
        Map<String, dynamic> res = body;
        return res;
      }
    } catch (err) {
      return err;
    }
  }
}
