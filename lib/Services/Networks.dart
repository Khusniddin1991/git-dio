




import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:getx_dio/Model/Model.dart';


class Network{
  List<Posting> data=List<Posting>();
  static Map<String,String> headers = {
    'Content-Type':'application/json; charset=UTF-8',
    "Accept":"application/json"
  };

  /* Http Apis */

  static String API_LIST = "https://jsonplaceholder.typicode.com/posts";
  static String API_CREATE = "https://jsonplaceholder.typicode.com/posts";
  static String API_UPDATE = "https://jsonplaceholder.typicode.com/posts/"; //{id}
  static String API_DELETE = "https://jsonplaceholder.typicode.com/posts/"; //{id}

  Future<List<Posting>> GET(String endPoint) async {
    Response response;
    Dio dio=Dio();
    try {
      response = await dio.get(endPoint,
          options: Options(
              headers:headers
          )
      );
      if(response.statusCode==200){
        for(var item in response.data){
          data.add(Posting.fromJson(item));
        }
        return data;
      }
      else{
        print("there is something wrong here");
        initializeInterceptor();
      }
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }
  Future DEL(String endPoint) async {
    Response response;
    Dio dio=Dio();
    try {
      response = await dio.get(endPoint,
          options: Options(
              headers:headers
          )
      );
      if(response.statusCode==200){
        for(var item in response.data){
          data.add(Posting.fromJson(item));
        }
        return data;
      }
      else{
        print("there is something wrong here");
        initializeInterceptor();
      }
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }


  Future POST(String data,Map<String, String> pars)async{
    Response response;
    Dio dios=Dio();
    response=await dios.post(data,options: Options(
      headers:headers,
    ),queryParameters:pars

    );
    try{
      if (response.statusCode==200){
        print(response);
        return response;
      }else {
        initializeInterceptor();
      }
    }on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

  }
  Future PUT(String data,Map<String, String> pars)async{
    Response response;
    Dio dios=Dio();
    response=await dios.post(data,options: Options(
      headers:headers,
    ),queryParameters:pars

    );
    try{
      if (response.statusCode==200&&response.statusCode==201){
        return response.data;
      }else {
        initializeInterceptor();
      }
    }on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

  }

  static initializeInterceptor(){
    var dio;
    dio.interceptors.add(InterceptorsWrapper(
        onError: (error, errorInterceptorHandler ){
          print(error.message);
        },
        onRequest: (request, requestInterceptorHandler){
          print("${request.method} | ${request.path}");
        },
        onResponse: (response, responseInterceptorHandler) {
          print('${response.statusCode} ${response.statusCode} ${response.data}');
        }
    ));
  }
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = new Map();
    return params;
  }

  static Map<String, dynamic> paramsCreate(Posting post) {
    Map<String, String> params = new Map();
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Posting post) {
    Map<String, String> params = new Map();
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  /* Http Parsing */

  static List<Posting> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Posting>.from(json.map((x) => Posting.fromJson(x)));
    return data;
  }




}