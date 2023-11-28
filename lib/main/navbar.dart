

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'halaman_agents.dart';
import 'halaman_weapons.dart';
import 'myprofile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async{
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
    });
  }

  int _selectedIndex = 0;
  final List<Widget> _page = [
    HalamanWeapons(),
    HalamanAgents(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.network(
                'https://assets.website-files.com/64c8ba1e1ec040c990d68596/65048ace6192a38a6214b6a9_002_RG_2021_FULL_LOCKUP_OFFWHITE.png',
                height: 25
            ),
            Spacer(),
            Text("Hi, ${username}", style: TextStyle(fontSize: 20),), //panggil username
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _page.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(

        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.network("https://media.valorant-api.com/weaponskins/46f32f75-4fc8-7121-8a77-db8db43afc67/displayicon.png",
              width: 30, height: 30,),
              label: 'Weapons',
            ),
            BottomNavigationBarItem(
              icon: Image.network("https://cdn3.emoji.gg/emojis/8733-controller-valorant.png",
                width: 25, height: 25,),
              label: 'Agents',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
