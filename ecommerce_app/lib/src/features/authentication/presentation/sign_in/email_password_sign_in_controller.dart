import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_password_sign_in_controller.g.dart';

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }
  Future<bool> submit({
    required String email,
    required String password,
    required EmailPasswordSignInFormType formType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authenticate(email, password, formType),
    );
    return state.hasError == false;
  }

  Future<void> _authenticate(
    String email,
    String password,
    EmailPasswordSignInFormType formType,
  ) {
    final authRepository = ref.read(authRepositoryProvider);
    return switch (formType) {
      EmailPasswordSignInFormType.signIn =>
        authRepository.signInWithEmailAndPassword(email, password),
      EmailPasswordSignInFormType.register =>
        authRepository.createUserWithEmailAndPassword(email, password)
    };
  }
}
