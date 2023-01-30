import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:user_list_sample/src/components/user_info.dart';
import 'package:user_list_sample/src/getx/user_list_controller.dart';
import 'package:user_list_sample/src/model/user_info_results.dart';

class UserListForGetx extends GetView<UserListController> {
  const UserListForGetx({super.key});

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error() {
    return const Center(
      child: Text('오류 발생'),
    );
  }

  Widget _userListWidget(List<UserInfo> userInfoList) {
    return ListView.separated(
      controller: controller.scrollController,
      itemBuilder: (context, index) {
        if (index == userInfoList.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UserInfoWidget(userInfo: userInfoList[index]);
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
      ),
      itemCount: userInfoList.length + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState 상태관리'),
      ),
      body: Obx(
          () => _userListWidget(controller.userInfoResult.value.userInfoList)),
    );
  }
}
