import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list_sample/src/model/user_info_results.dart';

class UserListCubitExtends extends Cubit<UserListCubitState> {
  late Dio _dio;
  UserListCubitExtends() : super(InitUserListCubitState()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    //로딩
    try {
      if (state is LoadingUserListCubitState ||
          state is ErrorUserListCubitState) {
        return;
      }
      print(state.userInfoResult.currentPage);
      emit(LoadingUserListCubitState(userInfoResult: state.userInfoResult));
      var result = await _dio.get('api', queryParameters: {
        'results': 10,
        'seed': 'sudar',
        'page': state.userInfoResult.currentPage,
      });
      await Future.delayed(Duration(milliseconds: 500));
      emit(LoadedUserListCubitState(
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data)));
    } catch (e) {
      emit(ErrorUserListCubitState(
          errorMessage: e.toString(), userInfoResult: state.userInfoResult));
    }

    //error
  }
}

abstract class UserListCubitState extends Equatable {
  final UserInfoResult userInfoResult;
  const UserListCubitState({required this.userInfoResult});
}

class InitUserListCubitState extends UserListCubitState {
  InitUserListCubitState() : super(userInfoResult: UserInfoResult.init());

  @override
  List<Object?> get props => [userInfoResult];
}

class LoadingUserListCubitState extends UserListCubitState {
  const LoadingUserListCubitState({required super.userInfoResult});

  @override
  List<Object?> get props => [userInfoResult];
}

class LoadedUserListCubitState extends UserListCubitState {
  const LoadedUserListCubitState({required super.userInfoResult});

  @override
  List<Object?> get props => [userInfoResult];
}

class ErrorUserListCubitState extends UserListCubitState {
  String errorMessage;
  ErrorUserListCubitState(
      {required this.errorMessage, required super.userInfoResult});

  @override
  List<Object?> get props => [errorMessage, userInfoResult];
}
