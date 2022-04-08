import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:admin_fake_identity/IdentityModel.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class IdentityList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<IdentityModel>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Identity List"),
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
                  'Add Identity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/addIdentity');
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
      body: listModel.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: listModel.personCount,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/identity', arguments: listModel.persons[index].blockHash);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200]!.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    listModel.persons[index].firstName.toUpperCase() + " " + listModel.persons[index].lastName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    listModel.persons[index].cin,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                              QrImage(
                                data: listModel.persons[index].blockHash,
                                version: QrVersions.auto,
                                size: 100.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
    );
  }
}