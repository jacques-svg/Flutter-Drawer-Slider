import 'package:flutter/material.dart';
import 'homepage.dart';
import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
          children: <Widget>[
            HomePage(),
            SideBar(),
          ],
        
      ),
    );
  }
}
