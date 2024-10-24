import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Site {
  final String name;
  final String ipAddress;
  final String port;

  Site({required this.name, required this.ipAddress, required this.port});
}

class AddSite extends StatelessWidget {
  final TextEditingController _siteNameController = TextEditingController();
  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

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
            const SizedBox(width: 15),
            const Text(
              'Add New Site',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _siteNameController,
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
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _ipAddressController,
                  decoration: InputDecoration(
                    hintText: 'IP address',
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
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _portController,
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
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    final newSite = Site(
                      name: _siteNameController.text,
                      ipAddress: _ipAddressController.text,
                      port: _portController.text,
                    );

                    final prefs = await SharedPreferences.getInstance();
                    List<String> siteList = prefs.getStringList('sites') ?? [];
                    siteList.add(newSite.name);
                    await prefs.setStringList('sites', siteList);

                    Navigator.pop(context, newSite);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB8500),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.black),
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
