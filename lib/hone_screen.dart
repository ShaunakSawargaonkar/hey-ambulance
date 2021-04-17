import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './Side_pannel.dart';
import 'package:dropdownfield/dropdownfield.dart';
import './map_screen.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hospital_input = '';
  @override
  List<String> hospitals = ['orion', 'cigma'];

  Map hospitalsPos = {
    'orion': {'Lat': 30.88873400275054, 'Long': 75.7903493245303},
    'cigma': {'Lat': 19.876838649268407, 'Long': 75.34805409866875},
    // 'ghati': '19.87695128006629, 75.34426534284552',
    // 'Krishna': '19.8763530530642, 75.33659847286289',
    // 'govt hospital': '19.8763530530642, 75.33659847286289'
  };
  List signal_input = [];
  var ab = '';
  List signals = ['signal1', 'signal2', 'signal3'];
  Map signal = {
    'signal1': {'Lat': 19.873300, 'Long': 75.324840},
    'signal2': {'Lat': 19.875064, 'Long': 75.333918},
    'signal3': {'Lat': 19.850826, 'Long': 75.334204},
  };
  @override
  Widget build(BuildContext context) {
    // Future _getCurrentLocation() async {
    //   Position position = await Geolocator()
    //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //   return position;
    // }

    Future everything() async {
      var position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var a = {
        "initialPos": position,
        'destinationPos': hospitalsPos[hospital_input]
      };
      return a;
    }

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hey Ambulance!!'),
      ),
      drawer: SidePanel(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            width: screenSize.width / 1.1,
            child: Container(
              color: Colors.white,
              child: DropDownField(
                onValueChanged: (value) {
                  setState(() {
                    hospital_input = value;
                  });
                },
                value: hospital_input,
                required: false,
                hintText: 'Choose Hospital',
                items: hospitals,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: screenSize.width / 1.1,
            child: DropDownField(
              onValueChanged: (value) {
                setState(() {
                  hospital_input = value;
                });
              },
              value: ab,
              required: false,
              hintText: 'Choose signal',
              items: signals,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              height: 150,
              width: 150,
              child: RaisedButton(
                onPressed: () async {
                  var a = await everything();
                  await Navigator.of(context)
                      .pushNamed(MapScreen.routeName, arguments: a);
                },
                color: Colors.deepOrange,
                textColor: Colors.white,
                shape: CircleBorder(side: BorderSide.none),
                child: Text(
                  'Summon Ambulance',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
