import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/components/appointment_card.dart';
import 'package:healthcare/utils/config.dart';
import 'package:healthcare/components/doctor_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user});

  final Map<String, dynamic>? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List medCate = [
    // {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    // {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiology"},
    // {"icon": FontAwesomeIcons.lungs, "category": "Respirations"},
    // {"icon": FontAwesomeIcons.hand, "category": "Dermatology"},
    // {"icon": FontAwesomeIcons.personPregnant, "category": "Gynecology"},
    // {"icon": FontAwesomeIcons.teeth, "category": "Dental"},
  ];

  List<dynamic> doctors = [];

  getCategory() async {
    String uri = 'http://10.0.2.2/healthcareDB/view_category.php';
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        medCate = jsonDecode(response.body);
      });
    } catch (e) {
      return e;
    }
  }

  getDoctor() async {
    String uri = 'http://10.0.2.2/healthcareDB/view_doctor.php';
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        doctors = jsonDecode(response.body);
      });
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    getCategory();
    getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCategory();
    getDoctor();
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${widget.user!['Patient_Name']}", // hard core the user's name at first
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            "assets/images/profile1.jpg"), // insert image here
                      ),
                    ),
                  ],
                ),
                Config.spaceSmall,
                // category listing
                const Text(
                  'Category', // hard core the user's name at first
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(medCate.length, (index) {
                      return Card(
                        margin: const EdgeInsets.only(right: 20),
                        color: Config.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              // FaIcon(
                              //   medCate[index]['icon'],
                              //   color: Colors.white,
                              // ),
                              // const SizedBox(width: 20),
                              Text(
                                medCate[index]['Specialty_Name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Appointment Today', // hard core the user's name at first
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //display appointment card here
                const AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Top Doctors', // hard core the user's name at first
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                // list of top doctors
                Column(
                  children: List.generate(doctors.length, (index) {
                    return DoctorCard(
                      route: 'doc_details',
                      doctor: doctors[index],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
