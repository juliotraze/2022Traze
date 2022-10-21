import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_example/Widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import 'devices.dart';

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo - Simple web app',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
     home: MyHomePage(),
    );
  }
}


getData(String uuid) async{
  //Authentication for Service Now Instance
  String username = 'admin';
  String password = 'wQCC3lLekW8u';
  //Encoding  login
  String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
  var response = await
  //get data from SN table
  get(Uri.parse("https://dev61351.service-now.com/api/now/table/u_positive_uuid"),
    headers: <String, String>{'authorization': basicAuth}, );


  if(response.body.toString().contains(uuid)){
    print("uuid here");

  }
}
postData() async{
  //Authentication for Service Now Instance
  String username = 'admin';
  String password = 'wQCC3lLekW8u';
  //Encoding  login
  String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
  //JSON Body we are sending to table
  var jsonBody = jsonEncode({"u_uuid": "e2bbe5bd-cd0f-4569-ae2c-fb68e1ffd7d","u_date": "2022-10-9"});
  //testing auth
    //print(basicAuth);
  //seeing wht we sending
    //print(jsonBody);
  //send data to server
  http.post(Uri.parse("https://dev61351.service-now.com/api/now/table/u_positive_uuid"),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Authorization': basicAuth},
      body: jsonBody);
  //Test Data
  //print('Response header: ${response.headers}');
  //print('Response status: ${response.statusCode}');
  //response.body is what is inside of the ServiceNow Table
 // print('Response body: ${response.body}');
  //We convert body to a string to use .contains function
 // var serviceNowList = response.body.toString();
  //if(serviceNowList.contains("u_uuid")){
 //   print("There is a UUID In here");
//  }
}
//end of post request



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  bool infected = false;
  TextEditingController testID = new TextEditingController();
  TextEditingController testResult = new TextEditingController();


  bool covidContact = false;
  bool currStatus = false;
  List<String> trazeUUIDList = <String>[];


  void showText() {
    setState(() {
      covidContact = !covidContact;
    });
  }

  final Random _random = Random();
  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
     var special = 8 + _random.nextInt(4);

    String uuid = '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';

    return uuid;
  }
  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);
  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');



  collectUUID(){
    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: 10));
    print("--------------This is the list-------");
    //print(FlutterBlue.instance.scan(results);
    //print(result);
    print("--------------This was the list-------");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Status",
          style: TextStyle(
            fontSize: 40,

          ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
              child: Container(
                height: 120.0,
                width: 170.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/Transparent_Waze.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Center(
              child: Text(
                "Welcome to Traze. If you come in contact with someonee who has tested positive for Covid-19 this page will notify you to get tested. If the page is blank then no contact has been made",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ),
            ),


    Visibility(
    visible: covidContact, //checks to see user contact status
        // if they are display text
    child: Text('You have had possible contact to Covid-19. Please notify yor supervisor and get tested as soon as possible.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 20,
        ),

    ),
    //maintainSize: bool. When true this is equivalent to invisible;
    //replacement: Widget. Defaults to Sizedbox.shrink, 0x0
    ),

            Center(
              child: new InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: new Text('Latest Covid-19 News',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      backgroundColor: Colors.lightGreen,
                    ),),
                  ),
                  onTap: () => launch('https://www.google.com')
              ),
            ),






            ElevatedButton( child: Text("Check Contact Status"),
                onPressed: (){
              if(infected = true){
                postData();
              }
              },
            ),

            StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data!
                    .map(
                      (r) => ScanResultTile(
                    result: r,
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      r.device.connect();
                      print("julio was also here------");
                      print(ScanResult);
                      print(r.advertisementData.serviceUuids);

                      return DeviceScreen(device: r.device);
                    })),
                  ),
                )
                    .toList(),
              ),
            ),//collectUUID(),

          ],
        ),
      ),
    );


  }

}
