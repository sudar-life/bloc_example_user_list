import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:user_list_sample/src/cubit/user_list.dart';
import 'package:user_list_sample/src/cubit/user_list_cubit_extends.dart';
import 'package:user_list_sample/src/cubit_copywith/user_list.dart';
import 'package:user_list_sample/src/cubit_copywith/user_list_cubit_copywith.dart';
import 'package:user_list_sample/src/getx/user_list.dart';
import 'package:user_list_sample/src/getx/user_list_controller.dart';
import 'package:user_list_sample/src/set_state/user_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserListPageSetState(),
                      ));
                },
                child: Text('SetState 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Get.put(UserListController());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserListForGetx(),
                      ));
                },
                child: Text('Getx 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => UserListCubitExtends(),
                            child: const UserListForCubitExtends()),
                      ));
                },
                child: Text('Extends 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => UserListCubitCopyWith(),
                            child: const UserListForCubitCopyWith()),
                      ));
                },
                child: Text('CopyWith 상태관리')),
          ],
        ),
      ),
    );
  }
}
