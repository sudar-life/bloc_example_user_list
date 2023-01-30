import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:user_list_sample/src/model/user_info_results.dart';

class UserListController extends GetxController {
  ScrollController scrollController = ScrollController();
  late Dio _dio;
  Rx<UserInfoResult> userInfoResult = UserInfoResult.init().obs;
  int nextPage = -1;
  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.7 <=
              scrollController.offset &&
          nextPage != userInfoResult.value.currentPage) {
        nextPage = userInfoResult.value.currentPage;
        _loadUserList();
      }
    });
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    var result = await _dio.get('api', queryParameters: {
      'results': 10,
      'seed': 'sudar',
      'page': userInfoResult.value.currentPage,
    });
    await Future.delayed(Duration(milliseconds: 500));
    userInfoResult(userInfoResult.value.copyWithFromJson(result.data));
  }
}
