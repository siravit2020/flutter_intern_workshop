// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Fingerprint extends StatefulWidget {
  @override
  _FingerprintState createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      Navigator.pop(context);
      print(e);
    }
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/fingerprint.svg',
                height: 200,
                color: _isAuthenticating ? Colors.purple : Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Current State: $_authorized\n'),
              RaisedButton(
                child: Text(_isAuthenticating ? 'Cancel' : 'Authenticate'),
                onPressed:
                    _isAuthenticating ? _cancelAuthentication : _authenticate,
              )
            ],
          ),
        ),
      ),
    );
  }
}
