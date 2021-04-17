import 'package:flutter/material.dart';
import './hone_screen.dart';

class SidePanel extends StatelessWidget {
  static final routeName = '/SidePanel';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.indigo,
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Container(
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home Screen"),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Other Info"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.call),
            title: Text("Contas Us"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text("Report"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
