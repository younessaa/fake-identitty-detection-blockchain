import 'dart:io';

import 'package:fake_identity_detection/Identity.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:fake_identity_detection/IdentityModel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class ScanIdentity extends StatefulWidget {

  @override
  _ScanIdentityState createState() => _ScanIdentityState();
}

class _ScanIdentityState extends State<ScanIdentity> {

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  bool barCodeValide(IdentityModel identityModel, String barCode) {
    if(barCode == null) {
      return false;
    }
    for (var item in identityModel.persons) {
      if(item.blockHash == barCode.toUpperCase())
        return true;
      
    }
    return false;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    await controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var listModel = Provider.of<IdentityModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Identity"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(
            bottom: 10, 
            child: buildResult("Scan a code !")
          ),
          Positioned(top: 10, child: buildButtons()),
        ],
      )
    );
  }

  Widget buildButtons() => Container(
    padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot) {
              if(snapshot.data != null) {
                return snapshot.data! ? Icon(Icons.flash_on) : Icon(Icons.flash_off);
              }
              else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {
              
            });
          },
        ),
        IconButton(
          icon: FutureBuilder(
            future: controller?.getCameraInfo(),
            builder: (context, snapshot) {
              if(snapshot.data != null) {
                return Icon(Icons.switch_camera);
              }
              else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {
              
            });
          },
        ),
      ],
    ),
  );

  Widget buildResult(String string) => Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      string,
      maxLines: 5,
    ),
  );

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderWidth: 10,
      borderLength: 20,
      borderRadius: 10,
      borderColor: Theme.of(context).accentColor,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream
        .listen((barCode) {
          setState(() => this.barcode = barCode);
          if(barCode != null) {
            Navigator.popAndPushNamed(context, '/identity', arguments: this.barcode?.code);
          }
        });
  }
}