//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {

  AnimationController _animationController;
  //final bool isSidebarOpened = true;
  StreamController<bool> isSidebarOpenedStreamContronller;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds:500);

  @override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamContronller = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamContronller.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamContronller.sink;
  }

  @override
  void dispose() {
    isSidebarOpenedStreamContronller.close();
    isSidebarOpenedSink.close();
    _animationController.dispose();
    super.dispose();
  }

  void onIconPressed (){
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted)
    {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    }
    else
    {
        isSidebarOpenedSink.add(true);
        _animationController.forward();
    }
    
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return  StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder:(context, isSideBarOpenedAsync){
        return AnimatedPositioned(
        duration:_animationDuration ,
        top: 0,
        bottom: 0,
        left: isSideBarOpenedAsync.data ? 0 :-screenWidth,
        right: isSideBarOpenedAsync.data  ? 0: screenWidth - 45,
            child: Row(
          children: <Widget>[
            Expanded(
              child:  Container(
                color: Color(0xFF262BAA),
                //decoration: Decoration(),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    ListTile(
                      title:Text(
                        "Doro Jacques",
                        style: TextStyle(color: Colors.white,fontSize:25),
                      ),
                      subtitle: Text(
                        "soromoudoro38@gmailcom",
                        style: TextStyle(color: Colors.white,fontSize:15),
                      ),
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.white,
                        ),
                        radius: 40,
                      ),
                    ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.cyan,
                      indent: 32,
                      endIndent: 32,
                    ),
                    ListTile(
                      leading: Icon(Icons.person,color: Colors.cyan),
                      title: Text(
                        'Profile',
                          style: TextStyle(color: Colors.white,fontSize:20),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings,color: Colors.cyan),
                      title: Text(
                        'Settings',
                        style: TextStyle(color: Colors.white,fontSize:20)
                     ),
                      onTap: () {},
                    ),
             Divider(
                height: 35,
                thickness: 0.5,
                      color: Colors.cyan,
                      indent: 32,
                      endIndent: 32,
              ),
            ListTile(
              leading: Icon(Icons.picture_in_picture,color: Colors.cyan),
              title: Text(
                'Map',
                style: TextStyle(color: Colors.white,fontSize:20),
                
              ),
              onTap: () {
                 /* Navigator.of(context).pop(); // permet de faire disparaitre le drawer une fois de retour
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => RestaurantPage(),
                  )); */
              },
            ),ListTile(
              leading: Icon(Icons.arrow_back,color: Colors.cyan),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white,fontSize:20),
              ),
              onTap: () {},
            )

                  ],
                ),
              ),

            ),
            Align(
              alignment: Alignment(0,-0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                                      child: Container(
                    width: 35,
                    height: 110,
                    color:Color(0xFF262AAA),
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close ,
                      color: Color(0xFF1BB5FD),
                      size: 25,
                    )
              ),
                  ),
                ),
            )
          ],
            
        ),
      );
      },
      
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path>{
  
  @override
  Path getClip(Size size){
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 1, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height -16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }

}