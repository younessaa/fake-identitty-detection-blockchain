
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:admin_fake_identity/IdentityModel.dart';

// ignore: must_be_immutable
class AddIdentity extends StatelessWidget {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<IdentityModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Add Identity")
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
                controller: t1,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
                controller: t2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                ),
                controller: t3,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CIN',
                ),
                controller: t4,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  await listModel.addPerson(t1.text, t2.text, t3.text, t4.text, );
                  t1.clear();
                  t2.clear();
                  t3.clear();
                  t4.clear();
                  Navigator.pushNamed(context, '/');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
              ))
        ],
      ),
    );
  }
  
}