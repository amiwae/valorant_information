import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/loginpage.dart';
import 'daftar_fav.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late SharedPreferences logindata;
  late String username;
  File? _image;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
    });
    setState(() async {
      _image = await File(logindata.getString("${username}Image")!);
    });
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> getImage() async {
    final XFile? image;
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
      logindata.setString("${username}Image", image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text("My Profile"),
          ],
        ),
      ),
      body: Container(
        height: 900,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFBD3944), Color(0xFF000000)],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipOval(
                              child: _image == null
                                  ? Image.network(
                                      "https://cdn.icon-icons.com/icons2/2645/PNG/512/person_icon_159921.png",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      _image!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        IconButton(
                          onPressed: () async {
                            await getImage();
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _image = null;
                                logindata.remove("${username}Image");
                              });
                            },
                            icon: Icon(Icons.delete)),
                        ElevatedButton(
                            onPressed: () {
                              logindata.setBool("login", true);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFbd3944),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("Logout")),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DaftarFav();
          }));
        },
        child: Icon(Icons.favorite),
        backgroundColor: Color(0xFFbd3944),
      ),
    );
  }
}
