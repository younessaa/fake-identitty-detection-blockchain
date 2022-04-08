import 'package:admin_fake_identity/Identity.dart';
import 'package:admin_fake_identity/add_identity.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:admin_fake_identity/IdentityList.dart';
import 'package:admin_fake_identity/IdentityModel.dart';

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
          '/addIdentity' : (context) => AddIdentity(),
          '/identity' : (context) => Identity(),
        },
      ),
    );
  }
}