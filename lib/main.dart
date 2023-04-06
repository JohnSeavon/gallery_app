import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/amplifyconfiguration.dart';
import 'package:gallery_app/features/gallery/services/auth_service.dart';
import 'package:gallery_app/features/gallery/controller/camera_flow.dart';
import 'package:gallery_app/features/gallery/ui/login_page.dart';
import 'package:gallery_app/features/gallery/ui/sign_up_page.dart';
import 'package:gallery_app/features/gallery/ui/verification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _amplify = Amplify;

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                if (snapshot.data?.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                    child: LoginPage(
                      didProvideCredentials: _authService.loginWithCredentials,
                      shouldShowSignUp: _authService.showSignUp,
                    ),
                  ),
                if (snapshot.data?.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                    child: SignUpPage(
                      didProvideCredentials: _authService.signUpWithCredentials,
                      shouldShowLogin: _authService.showLogin,
                    ),
                  ),
                if (snapshot.data?.authFlowStatus ==
                    AuthFlowStatus.verification)
                  MaterialPage(
                    child: VerificationPage(
                      didProvideVerificationCode: _authService.verifyCode,
                    ),
                  ),
                if (snapshot.data?.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                    child: CameraFlow(shouldLogOut: _authService.logOut),
                  )
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _configureAmplify() async {
    try {
      await _amplify.addPlugins([
        AmplifyAuthCognito(),
      ]);
      await _amplify.configure(amplifyconfig);
      debugPrint('Successfully configured Amplify 🎉');
    } catch (e) {
      debugPrint('Could not configure Amplify ☠️');
    }
  }
}
