import 'package:fake_identity_detection/Identity.dart';
import 'package:fake_identity_detection/scan_identity.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:fake_identity_detection/IdentityList.dart';
import 'package:fake_identity_detection/IdentityModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdentityModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/' : (context) => IdentityList(),
          '/scanIdentity' : (context) => ScanIdentity(),
          '/identity' : (context) => Identity(),
        },
      ),
    );
  }
}