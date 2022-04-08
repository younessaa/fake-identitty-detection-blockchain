import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:web3dart/web3dart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:web_socket_channel/io.dart';

class IdentityModel extends ChangeNotifier {
  List<Person> persons = [];
  bool isLoading = true;
  final String _rpcUrl = "http://192.168.253.78:7545";
  final String _wsUrl = "ws://192.168.253.78:7545/";

  final String _privateKey =
      "0d68027742c4772cc2a324390d6523069033f66b9ebe1584724322c74a012128";
  int personCount = 0;
  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late ContractFunction _personCount;
  late ContractFunction _persons;

  IdentityModel() {
    initiateSetup();
    print("%%%%%%%%%%%%%%%%%5");
  }

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/IdentityModel.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
    print(_ownAddress);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "IdentityModel"), _contractAddress);

    _personCount = _contract.function("personCount");
    _persons = _contract.function("persons");
    print("####");
    await getPersons();
    print("####");
    // print("");
  }

  Future<void> getPersons() async {
    List totalPersonsList = await _client
        .call(contract: _contract, function: _personCount, params: []);

    BigInt totalPersons = totalPersonsList[0];
    personCount = totalPersons.toInt();

    persons.clear();
    for (var i = 0; i < totalPersons.toInt(); i++) {
      var temp = await _client.call(
          contract: _contract, function: _persons, params: [BigInt.from(i)]);
      persons.add(Person(firstName: temp[0], lastName: temp[1], addrss: temp[2], cin: temp[3], date: temp[4], blockHash: temp[5]));
      print(temp);
    }

    isLoading = false;
    notifyListeners();
  }

}

class Person {
  String firstName;
  String lastName;
  String addrss;
  String cin;
  String date;
  String blockHash;
  Person({required this.firstName,required this.lastName,required this.addrss,required this.cin, required this.date, required this.blockHash});
}