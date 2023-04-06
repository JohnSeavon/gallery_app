import 'package:flutter/material.dart';
import 'package:gallery_app/features/gallery/analytics/analytics_events.dart';
import 'package:gallery_app/features/gallery/data/auth_credentials.dart';
import 'package:gallery_app/features/gallery/services/analytics_service.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;

  final VoidCallback shouldShowSignUp;

  const LoginPage({
    required this.didProvideCredentials,
    required this.shouldShowSignUp,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            _loginForm(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 8),
              child: TextButton(
                  onPressed: widget.shouldShowSignUp,
                  child: const Text('Don\'t have an account? Sign up.')),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
              icon: Icon(Icons.mail), labelText: 'Username'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _login,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text('Login'),
        ),
      ],
    );
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final credentials = LoginCredentials(
      username: username,
      password: password,
    );
    widget.didProvideCredentials(credentials);
    AnalyticsService.log(LoginEvent());
  }
}
