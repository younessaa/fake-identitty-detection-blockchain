import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Identity Detection"),
      ),
      drawer: Drawer(
        child: Container(
          width: width * 0.8,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Fake Identity Detection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Scan Identity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/scanIdentity');
                },
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/scanIdentity');
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue[300],
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
          ),
          child: Text(
            "Scan Idenity",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}