abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({required this.username, required this.password});
}

class LoginCredentials extends AuthCredentials {
  LoginCredentials({required username, required password})
      : super(username: username, password: password);
}

class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({required username, required password, required this.email})
      : super(username: username, password: password);
}
