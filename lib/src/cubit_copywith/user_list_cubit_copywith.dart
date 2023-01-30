import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list_sample/src/model/user_info_results.dart';

class UserListCubitCopyWith extends Cubit<UserListCubitState> {
  late Dio _dio;
  UserListCubitCopyWith() : super(UserListCubitState.init()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    //로딩
    try {
      if (state.status == UserListCubitStatus.loading ||
          state.status == UserListCubitStatus.error) {
        return;
      }
      print(state.userInfoResult.currentPage);
      emit(state.copyWith(status: UserListCubitStatus.loading));
      var result = await _dio.get('api', queryParameters: {
        'results': 10,
        'seed': 'sudar',
        'page': state.userInfoResult.currentPage,
      });
      await Future.delayed(Duration(milliseconds: 500));
      emit(state.copyWith(
          status: UserListCubitStatus.loaded,
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data)));
    } catch (e) {
      emit(state.copyWith(
          status: UserListCubitStatus.error, errorMessage: e.toString()));
    }

    //error
  }
}

enum UserListCubitStatus {
  init,
  loading,
  loaded,
  error,
}

class UserListCubitState extends Equatable {
  final UserListCubitStatus status;
  final UserInfoResult userInfoResult;
  final String? errorMessage;
  const UserListCubitState({
    required this.status,
    required this.userInfoResult,
    this.errorMessage,
  });

  UserListCubitState.init()
      : this(
            status: UserListCubitStatus.init,
            userInfoResult: UserInfoResult.init());

  UserListCubitState copyWith({
    UserListCubitStatus? status,
    UserInfoResult? userInfoResult,
    String? errorMessage,
  }) {
    return UserListCubitState(
      status: status ?? this.status,
      userInfoResult: userInfoResult ?? this.userInfoResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userInfoResult,
        errorMessage,
      ];
}
