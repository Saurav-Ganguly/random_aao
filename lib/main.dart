import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_aao/widgets/custom_card.dart';
import 'package:random_aao/person.dart';
import 'package:random_aao/dart_func/get_csv_data.dart';
import 'dart:async' show Future;

void main(List<String> args) {
  runApp(const MaterialApp(
    home: RandomAAO(),
  ));
}

class RandomAAO extends StatefulWidget {
  const RandomAAO({super.key});

  @override
  State<RandomAAO> createState() => _RandomAAOState();
}

class _RandomAAOState extends State<RandomAAO> {
  Person myPerson = Person(
      name: "loading",
      dateOfBirth: "loading",
      rollNo: "loading",
      selectedCat: "loading",
      state: "loading",
      rank: "loading");

  Future<void> fetchPerson() async {
    Person data = await readCsvFile(38);
    setState(() {
      myPerson = data;
    });
  }

  void nextPerson() async {
    var newRecord = Random().nextInt(1462);
    var newPerson = await readCsvFile(newRecord);
    setState(() {
      myPerson = newPerson;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assistant Audit Officer 2022"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: CustomCard(
              name: myPerson.name,
              rollNo: myPerson.rollNo,
              category: myPerson.selectedCat,
              rank: myPerson.rank,
              state: myPerson.state,
              icon: Icons.person,
            ),
          ),
          ElevatedButton(
              onPressed: nextPerson,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "NEXT >",
                  style: TextStyle(fontSize: 30),
                ),
              ))
        ],
      ),
    );
  }
}
