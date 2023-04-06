import 'package:flutter/material.dart';
import 'package:gallery_app/features/gallery/analytics/analytics_events.dart';
import 'package:gallery_app/features/gallery/data/auth_credentials.dart';
import 'package:gallery_app/features/gallery/services/analytics_service.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;

  final VoidCallback shouldShowLogin;

  const SignUpPage({
    required this.didProvideCredentials,
    required this.shouldShowLogin,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            _signUpForm(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 8),
              child: TextButton(
                  onPressed: widget.shouldShowLogin,
                  child: const Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
              icon: Icon(Icons.person), labelText: 'Username'),
        ),
        TextField(
          controller: _emailController,
          decoration:
              const InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
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
          onPressed: _signUp,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: const Text('Sign Up'),
        )
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final credentials = SignUpCredentials(
      username: username,
      password: password,
      email: email,
    );
    widget.didProvideCredentials(credentials);
    AnalyticsService.log(SignUpEvent());
  }
}
