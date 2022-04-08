import 'package:admin_fake_identity/IdentityModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';



class Identity extends StatelessWidget {
  Person person = new Person(firstName: '',lastName: '', addrss: '', cin: '', date: '', blockHash: '');

  Person getPerson(IdentityModel identityModel, String barcode) {

    if(barcode == null) {
      return Person(firstName: '',lastName: '', addrss: '', cin: '', date: '', blockHash: '');
    }

    for (var item in identityModel.persons) {
      if(item.blockHash == barcode)
        return item;
      
    }
    return Person(firstName: '',lastName: '', addrss: '', cin: '', date: '', blockHash: '');
  }

  @override
  Widget build(BuildContext context) {
    final barCode = ModalRoute.of(context)!.settings.arguments as String;
    var listModel = Provider.of<IdentityModel>(context);
    person = getPerson(listModel, barCode);

    return Scaffold(
      appBar: AppBar(
        title: Text("Identity Detection"),
      ),
      body: !isPerson(person) ?Center(
        child : Text(
          "Fake Identity Detected !!!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        )
      )
      : showIdentity(person),
    );
  }

  ListView showIdentity(Person per) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                per.firstName.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                per.lastName.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "CIN : " + per.cin,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Address : " + per.addrss,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QrImage(
              data: per.blockHash,
              version: QrVersions.auto,
              size: 280.0,
            ),
          ],
        ),
      ],
    );
  }

  bool isPerson(Person person) {
    if(person == null) {
      return false;
    }
    if( person.firstName == '' && person.lastName == '' && person.addrss == '' && person.cin =='' && person.date == '' )
      return false;
    else
      return true;
  }
}