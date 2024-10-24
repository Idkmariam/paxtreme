import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  final String siteName;
  final String ipAddress;
  final String port;

  Edit({required this.siteName, required this.ipAddress, required this.port});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  String siteName = '';
  String ipAddress = '';
  String port = '';

  @override
  void initState() {
    super.initState();
    siteName = widget.siteName;
    ipAddress = widget.ipAddress;
    port = widget.port;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF023047),
      appBar: AppBar(
        backgroundColor: const Color(0xFF023047),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color(0xFF8ECAE6),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 20),
            const Text(
              'Edit Information',
              style: TextStyle(
                color: Color(0xFFFB8500),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    siteName = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Site Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFF332B2B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.location_on, color: Color(0xFFFB8500)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: TextEditingController(text: siteName),
                ),
                const SizedBox(height: 50),
                TextField(
                  onChanged: (value) {
                    ipAddress = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'IP Address',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFF332B2B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.public, color: Color(0xFFFB8500)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: TextEditingController(text: ipAddress),
                ),
                const SizedBox(height: 50),
                TextField(
                  onChanged: (value) {
                    port = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Port',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFF332B2B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.input, color: Color(0xFFFB8500)),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: port),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedSite = {
                        'name': siteName,
                        'ip': ipAddress,
                        'port': port,
                      };

                      final prefs = await SharedPreferences.getInstance();
                      List<String> siteList = prefs.getStringList('sites') ?? [];
                      siteList[0] = updatedSite['name']!;
                      await prefs.setStringList('sites', siteList);

                      Navigator.pop(context, updatedSite);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB8500),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Color(0xFF023047)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
