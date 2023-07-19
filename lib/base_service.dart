library dev_storage_package;

import 'dart:io';

import 'package:dev_storage_package/dev_storage_package.dart';
import 'package:dev_storage_package/internet_connection_checker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:dio/dio.dart' as dio;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiClient extends GetxService {
  //late String token;
  late dio.Dio dioD;
  String tokenKey;
  String baseUrl;
  DevStorage devStorage;
  late Map<String, String> _mainHeaders;
  InternetConnectionCheckerDev connectivityController = Get.find();

  ApiClient(
      {required this.devStorage,
      required this.baseUrl,
      required this.tokenKey}) {
    //token = devStorage.getKeysValue(tokenKey) ??  "";
    /*_mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };*/

    var options = dio.BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
    );

    dioD = dio.Dio(options);
  }

  post(String uri, Map<String, dynamic>? query, datax) async {
    if (!connectivityController.isConnected) {
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 503);
    }

    String? token = devStorage.getKeysValue(tokenKey);
    //bool? isLogged = devStorage.getIsLogged();
    Map<String, dynamic>? headersw = {};

    if (token == null) {
      headersw = null;
    }
    if (token != null) {
      headersw = {"Authorization": "Bearer $token"};
    }

    try {
      dio.Response response = await dioD.post(uri,
          data: datax,
          queryParameters: query ?? null,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            responseType: dio.ResponseType.json,
            headers: headersw,
          ));
      //print('\x1B[31m${response.data.toString()}\x1B[0m');
      return response;
    } catch (e) {
      print('\x1B[31m Error on post: ${e.toString()}\x1B[0m');
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 1);
    }
  }

  get(String uri, Map<String, dynamic>? query) async {
    if (!connectivityController.isConnected) {
      //getx.Get.snackbar("Internet Error", "You can not use this method offline", backgroundColor: UiConstants.orange);
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 503);
    }

    String? token = devStorage.getKeysValue(tokenKey);
    //bool? isLogged = devStorage.getIsLogged();
    Map<String, dynamic>? headersw = {};
    if (token == null) {
      headersw = null;
    }
    if (token != null) {
      headersw = {"Authorization": "Bearer $token"};
    }
    try {
      dio.Response response = await dioD.get(uri,
          queryParameters: query ?? null,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            responseType: dio.ResponseType.json,
            headers: headersw,
          ));
      //print('\x1B[31m${response.data.toString()}\x1B[0m');
      //print(response.data.toString());
      //print(response.statusCode);
      return response;
    } catch (e) {
      print('\x1B[31mError on post: ${e.toString()}\x1B[0m');
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 1);
    }
  }

  put(String uri, Map<String, dynamic>? query, datax) async {
    if (!connectivityController.isConnected) {
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 503);
    }

    String? token = devStorage.getKeysValue(tokenKey);
    //bool? isLogged = devStorage.getIsLogged();
    Map<String, dynamic>? headersw = {};

    if (token == null) {
      headersw = null;
    }
    if (token != null) {
      headersw = {"Authorization": "Bearer $token"};
    }

    try {
      dio.Response response = await dioD.put(uri,
          data: datax,
          queryParameters: query ?? null,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            responseType: dio.ResponseType.json,
            headers: headersw,
          ));
      //print('\x1B[31m${response.data.toString()}\x1B[0m');
      return response;
    } catch (e) {
      print('\x1B[31m Error on put: ${e.toString()}\x1B[0m');
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 1);
    }
  }

  delete(String uri, Map<String, dynamic>? query, datax) async {
    if (!connectivityController.isConnected) {
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 503);
    }

    String? token = devStorage.getKeysValue(tokenKey);
    //bool? isLogged = devStorage.getIsLogged();
    Map<String, dynamic>? headersw = {};

    if (token == null) {
      headersw = null;
    }
    if (token != null) {
      headersw = {"Authorization": "Bearer $token"};
    }

    try {
      dio.Response response = await dioD.delete(uri,
          data: datax,
          queryParameters: query ?? null,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            responseType: dio.ResponseType.json,
            headers: headersw,
          ));
      //print('\x1B[31m${response.data.toString()}\x1B[0m');
      return response;
    } catch (e) {
      print('\x1B[31m Error on delete: ${e.toString()}\x1B[0m');
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 1);
    }
  }

  upload(String uri, Map<String, dynamic>? query, datax, File file,
      String? fileNameToApi) async {
    if (!connectivityController.isConnected) {
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 503);
    }

    String fileName = file.path.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      fileNameToApi ?? "file":
          await dio.MultipartFile.fromFile(file.path, filename: fileName),
    });

    String? token = devStorage.getKeysValue(tokenKey);
    //bool? isLogged = devStorage.getIsLogged();
    Map<String, dynamic>? headersw = {};

    if (token == null) {
      headersw = null;
    }
    if (token != null) {
      headersw = {"Authorization": "Bearer $token"};
    }

    try {
      dio.Response response = await dioD.post(uri,
          data: formData,
          queryParameters: query ?? null,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            responseType: dio.ResponseType.json,
            headers: headersw,
          ));
      //print('\x1B[31m${response.data.toString()}\x1B[0m');
      return response;
    } catch (e) {
      print('\x1B[31m Error on upload file: ${e.toString()} \x1B[0m');
      return dio.Response(
          requestOptions: dio.RequestOptions(
            path: uri,
          ),
          statusCode: 1);
    }
  }
}
