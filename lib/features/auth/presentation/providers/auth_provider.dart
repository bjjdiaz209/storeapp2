import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastucture/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastucture/infrastructure.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('error no desconocido');
    }

    // final user = await authRepository.login(email, password);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void registerUser(String email, String password, String fullName) async {
    // final user = await authRepository.register(email, password, fullName);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void checkAuthStatus() async {
    // final user = await authRepository.checkAuthStatus(token);
    // state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void _setLoggedUser(User user) {
    //TODO: save user token to local storage
    state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  Future<void> logout([String? errorMessage]) async {
    //TODO: remove token user from local storage

    state = state.copyWith(
      authStatus: AuthStatus.notauthenticated,
      user: null,
      errorMessage: errorMessage,
    );

    // await authRepository.logout();
    // state = state.copyWith(authStatus: AuthStatus.notauthenticated, user: null);
  }
}

enum AuthStatus { checking, authenticated, notauthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String? errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
