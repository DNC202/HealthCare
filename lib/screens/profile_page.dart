import 'package:flutter/material.dart';
import 'package:healthcare/screens/auth_page.dart';
import 'package:healthcare/utils/config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.user});

  final Map<String, dynamic>? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: 110),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage("assets/images/profile1.jpg"),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.user!['Patient_Name']}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.user!['Patient_Age']} Years old",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: EdgeInsets.only(top: 45),
                child: SizedBox(
                  width: 300,
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Divider(color: Colors.grey[300]),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.blueAccent[400],
                              size: 35,
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  color: Colors.blueAccent[400],
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.red[400],
                              size: 35,
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pushNamed('/');
                                });
                              },
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.red[400],
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
