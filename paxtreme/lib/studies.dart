import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'filtration.dart';
import 'login.dart';

class Patient {
  final String name;
  final String id;
  final String sex;
  final String date;
  final String time;
  final String number;
  final String type;
  final List<String> dicomImages;
  final String image;

  Patient({
    required this.name,
    required this.id,
    required this.sex,
    required this.date,
    required this.time,
    required this.number,
    required this.type,
    required this.dicomImages,
    required this.image,
  });
}

class Studies extends StatefulWidget {
  const Studies({super.key});

  @override
  State<Studies> createState() => _StudiesState();
}

class _StudiesState extends State<Studies> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  List<String> currentDicomImages = [];
  bool isSidebarOpen = false;

  final List<Patient> patients = [
    Patient(
      name: "Mariam Ibrahim",
      id: "ID: 123456",
      sex: "Sex: Female",
      date: "Date: 2024-10-12",
      time: "14:35",
      number: "4/324",
      type: "CT 0",
      dicomImages: [
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
      ],
      image: 'assets/dicom.jpeg',
    ),
    Patient(
      name: "Mariam Ibrahim",
      id: "ID: 123456",
      sex: "Sex: Female",
      date: "Date: 2024-10-12",
      time: "14:35",
      number: "4/324",
      type: "CT 0",
      dicomImages: [
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
      ],
      image: 'assets/dicom.jpeg',
    ),
    Patient(
      name: "Mariam Ibrahim",
      id: "ID: 123456",
      sex: "Sex: Female",
      date: "Date: 2024-10-12",
      time: "14:35",
      number: "4/324",
      type: "CT 0",
      dicomImages: [
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
      ],
      image: 'assets/dicom.jpeg',
    ),
    Patient(
      name: "Mariam Ibrahim",
      id: "ID: 123456",
      sex: "Sex: Female",
      date: "Date: 2024-10-12",
      time: "14:35",
      number: "4/324",
      type: "CT 0",
      dicomImages: [
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
      ],
      image: 'assets/dicom.jpeg',
    ),
    Patient(
      name: "Mariam Ibrahim",
      id: "ID: 123456",
      sex: "Sex: Female",
      date: "Date: 2024-10-12",
      time: "14:35",
      number: "4/324",
      type: "CT 0",
      dicomImages: [
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
        'assets/dicom.jpeg',
      ],
      image: 'assets/dicom.jpeg',
    ),
    // Add more patients...
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSidebar(List<String> dicomImages) {
    setState(() {
      currentDicomImages = dicomImages;
      if (isSidebarOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isSidebarOpen = !isSidebarOpen;
    });
  }

  void _closeSidebar() {
    if (isSidebarOpen) {
      _controller.reverse();
      setState(() {
        isSidebarOpen = false;
      });
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF023047), // Background color
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
                color: Colors.white, fontSize: 20.0), // Content text color
          ),
          actions: [
            // Wrap buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Perform logout operation and navigate to the login screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              Login()), // Replace with your login screen widget
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Color(0xFFFB8500),
                        fontSize: 20.0), // Button color
                  ),
                ),
                const SizedBox(width: 20), // Space between buttons
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Color(0xFFFB8500),
                        fontSize: 20.0), // Button color
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not launch $url');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF023047),
      appBar: AppBar(
        backgroundColor: const Color(0xFF023047),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Studies',
          style: TextStyle(
            color: Color(0xFFFB8500),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFFB8500)),
            onPressed: _logout,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _closeSidebar, // Close sidebar on tap anywhere on the screen
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(370, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xFFFB8500),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Filtration(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Color(0xFF023047),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.filter_alt,
                          color: Color(0xFF023047),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ListView for displaying patient details
                Expanded(
                  child: ListView.builder(
                    itemCount: patients.length * 2 - 1,
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        );
                      }

                      final patientIndex = index ~/ 2;
                      final patient = patients[patientIndex];

                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF023047),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(4, 4),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      patient.image,
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  Text(patient.id,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Text(patient.sex,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Text(patient.date,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Text(patient.time,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Text(patient.number,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Text(patient.type,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                // Series button
                                Container(
                                  width: 35,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFB8500),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.view_list),
                                      color: const Color(0xFF023047),
                                      iconSize: 20,
                                      onPressed: () {
                                        _toggleSidebar(patient.dicomImages);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Eye button
                                Container(
                                  width: 35,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFB8500),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.visibility),
                                      color: const Color(0xFF023047),
                                      iconSize: 20,
                                      onPressed: () {
                                        _openUrl(
                                            'https://www.google.com/chrome/'); // Call the method to open URL
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Sidebar (Slide in from the right)
            SlideTransition(
              position: _offsetAnimation,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: screenWidth * 0.5, // Width of the sidebar
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 5, 39, 56),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Frame on the left side with radius

                      Container(
                        width: 40, // Width of the frame
                        decoration: const BoxDecoration(
                          color: Color(0xFFFB8500), // Frame color
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                20), // Top-left radius for the frame
                          ),
                        ),
                        child: const Center(
                          child: RotatedBox(
                            // Use RotatedBox instead of Transform
                            quarterTurns:
                                3, // Rotate 90 degrees counterclockwise
                            child: Text(
                              'Series',
                              style: TextStyle(
                                color: Color(0xFF023047),
                                fontWeight: FontWeight.bold,
                                fontSize: 20, // Adjust size
                              ),
                              textAlign: TextAlign.center, // Center the text
                            ),
                          ),
                        ),
                      ),

                      // Sidebar content
                      Expanded(
                        child: ListView.builder(
                          itemCount: currentDicomImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    15), // Set border radius here
                                child: Image.asset(
                                  currentDicomImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
