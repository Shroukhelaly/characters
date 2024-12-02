import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constance/constance.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      //receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }

  Future<List> getAllCharacters() async {
    try {
      var response = await dio.get('character#');
      return response.data["results"];

    } catch (e) {
      debugPrint('error on catch ${e.toString()}');
      return [];
    }
  }
}
