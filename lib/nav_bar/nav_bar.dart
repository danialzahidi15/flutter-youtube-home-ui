import 'package:flutter/material.dart';
import 'package:youtube_demo/screen/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget> [
    Home(),
    Text('data 2'),
    Text('data 3'),
    Text('data 4'),
    Text('data 5'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        // selectedItemColor: Colors.red,
        selectedItemColor: Colors.amber,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Shorts',
            icon: Icon(
              Icons.slow_motion_video_sharp,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Subsciptions',
            icon: Icon(
              Icons.subscriptions_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Library',
            icon: Icon(
              Icons.video_library_outlined,
              color: Colors.black,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
