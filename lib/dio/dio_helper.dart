import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://medicalapp.eraasoft.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String ,dynamic>? query,
    String? token,
  }) async
  {
    dio!.options.headers=
    {
      "Content-Type":"application/json",
      "Authorization":"bearer$token",
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }



  static Future<Response> postData({
    required String url,
      Map<String,dynamic>? data,
    String? token,
  })async
  {
    dio!.options.headers=
    {
      "Content-Type":"application/json",
      "Authorization":"bearer$token",
    };
    return await dio!.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String ,dynamic>? query,
    required Map<String,dynamic> data,
    String lang = "en",
    String? token,
  })async
  {
    dio!.options.headers=
    {
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":token,
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

}