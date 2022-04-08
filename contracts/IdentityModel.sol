pragma solidity ^0.5.0;

contract IdentityModel {
    uint256 public personCount;

    struct Person {
        string firstName;
        string lastName;
        string addrss;
        string cin;
        string date;
        string blockHash;
    }

    mapping(uint256 => Person) public persons;

    event PersonCreated(string firstName, string lastName, string addrss, string cin, string date, string blockHash, uint256 personNumber);

    constructor() public {
        persons[0] = Person("youness", "aabaoui", "rabat", "X411449", "2022-04-06 02:09:30.375", "40CF7DBA9760A14FDB3104CE5D1215349DC3751576E124C311B35286FC3658DC");
        personCount = 1;
    }

    function createPerson(string memory _firstName, string memory _lastName, string memory _addrss, string memory _cin, string memory _date, string memory _blockHash) public {
        persons[personCount++] = Person(_firstName, _lastName, _addrss, _cin, _date, _blockHash);

        emit PersonCreated(_firstName, _lastName, _addrss, _cin, _date, _blockHash, personCount - 1);
    }
}