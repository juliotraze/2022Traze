import 'package:flutter/material.dart';
import 'package:flutter_blue_example/UI%20Screens/devices.dart';
import 'package:flutter_blue_example/UI%20Screens/status.dart';
import 'package:flutter_blue_example/UI%20Screens/test_submit.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../Covid API/covid.dart';
import '../Widgets/header.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance
        .startScan(timeout: Duration(seconds: 4));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = Status();
    }else if (currentPage == DrawerSections.covid) {
      container = Covid();
    }else if (currentPage == DrawerSections.test) {
      container = Test();
    }else if (currentPage == DrawerSections.devices) {
      container = Devices();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],


        title: Row(
          mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('Traze')),
            //Image.asset('images/Transparent_Waze.logo',
                //fit: BoxFit.contain,
                //height: 20,width: 20,
              //),



            ],
        ),
      ),
      body: container,

      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          Divider(),
          menuItem(1, "Home", Icons.dashboard_outlined,
              currentPage == DrawerSections.home ? true : false),
          Divider(),
          menuItem(2, "Covid-19 Statistics", Icons.people_alt_outlined,
              currentPage == DrawerSections.covid ? true : false),
          Divider(),
          menuItem(3, "Submit Test Results", Icons.event,
              currentPage == DrawerSections.test ? true : false),
          Divider(),
          menuItem(4, "Nearby Devices", Icons.notes,
              currentPage == DrawerSections.devices ? true : false),
          Divider(),

        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.covid;
            } else if (id == 3) {
              currentPage = DrawerSections.test;
            } else if (id == 4) {
              currentPage = DrawerSections.devices;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  home,
  covid,
  test,
  devices,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}