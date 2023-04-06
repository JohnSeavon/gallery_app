import 'package:flutter/material.dart';
import 'package:gallery_app/features/gallery/analytics/analytics_events.dart';
import 'package:gallery_app/features/gallery/services/analytics_service.dart';

class VerificationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;

  const VerificationPage({required this.didProvideVerificationCode, super.key});

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      ),
    );
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _verificationCodeController,
          decoration: const InputDecoration(
              icon: Icon(Icons.confirmation_number),
              labelText: 'Verification code'),
        ),
        TextButton(
          onPressed: _verify,
          child: const Text('Verify'),
        )
      ],
    );
  }

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode(verificationCode);
    AnalyticsService.log(VerificationEvent());
  }
}
