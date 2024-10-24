import 'package:flutter/material.dart';
import 'package:paxtreme/AddSite.dart';
import 'package:paxtreme/EditInformation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteSettings extends StatefulWidget {
  const SiteSettings({super.key});

  @override
  State<SiteSettings> createState() => _SiteSettingsState();
}

class _SiteSettingsState extends State<SiteSettings> {
  List<Map<String, String>> sites = [];
  int? pinnedSiteIndex;

  @override
  void initState() {
    super.initState();
    _loadSites();
  }

  Future<void> _loadSites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedSites = prefs.getStringList('sites');
    List<Map<String, String>> loadedSites = [];

    if (savedSites != null) {
      for (String site in savedSites) {
        final parts = site.split(',');
        if (parts.length == 3) {
          loadedSites.add({
            'name': parts[0],
            'ip': parts[1],
            'port': parts[2],
          });
        }
      }
    }

    pinnedSiteIndex = prefs.getInt('pinnedSiteIndex');

    setState(() {
      sites = loadedSites;
    });
  }

  Future<void> _saveSites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedSites = sites.map((site) {
      return '${site['name']},${site['ip']},${site['port']}';
    }).toList();

    await prefs.setStringList('sites', savedSites);
    await prefs.setInt('pinnedSiteIndex', pinnedSiteIndex ?? -1);
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
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color(0xFF8ECAE6),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10),
            const Text(
              'Site Settings',
              style: TextStyle(
                color: Color(0xFFFB8500),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFB8500),
                  minimumSize: Size(screenWidth * 0.9, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
                onPressed: () async {
                  final newSite = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSite(),
                    ),
                  );

                  if (newSite != null && newSite is Site) {
                    setState(() {
                      sites.add({
                        'name': newSite.name,
                        'ip': newSite.ipAddress,
                        'port': newSite.port,
                      });
                    });
                    await _saveSites();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Site',
                      style: TextStyle(
                        color: Color(0xFF023047),
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFB8500),
                        border: Border.all(
                          color: const Color(0xFF023047),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xFF023047),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              if (pinnedSiteIndex != null && pinnedSiteIndex! >= 0 && pinnedSiteIndex! < sites.length) ...[
                _buildSiteEntry(
                  context,
                  pinnedSiteIndex!,
                  siteName: sites[pinnedSiteIndex!]['name']!,
                  ip: sites[pinnedSiteIndex!]['ip']!,
                  port: sites[pinnedSiteIndex!]['port']!,
                ),
                if (pinnedSiteIndex != sites.length - 1)
                  const Divider(
                    color: Color(0xFF858585),
                    thickness: 1,
                    height: 1,
                  ),
              ],

              for (int i = 0; i < sites.length; i++)
                if (i != pinnedSiteIndex)
                  Column(
                    children: [
                      _buildSiteEntry(
                        context,
                        i,
                        siteName: sites[i]['name']!,
                        ip: sites[i]['ip']!,
                        port: sites[i]['port']!,
                      ),
                      const Divider(
                        color: Color(0xFF858585),
                        thickness: 1,
                        height: 1,
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSiteEntry(BuildContext context, int index,
      {required String siteName, required String ip, required String port}) {
    return Opacity(
      opacity: 1.0,
      child: Container(
        width: 376,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF023047),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Site: $siteName',
              style: const TextStyle(
                color: Color(0xFF8ECAE6),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'IP: $ip',
              style: const TextStyle(
                color: Color(0xFF8ECAE6),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Port: $port',
              style: const TextStyle(
                color: Color(0xFF8ECAE6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(Icons.push_pin, () {
                  setState(() {
                    pinnedSiteIndex = index;
                  });
                  _saveSites();
                }),
                _buildActionButton(Icons.edit, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Edit(
                        siteName: siteName,
                        ipAddress: ip,
                        port: port,
                      ),
                    ),
                  ).then((updatedSite) {
                    if (updatedSite != null) {
                      setState(() {
                        sites[index] = updatedSite;
                      });
                      _saveSites();
                    }
                  });
                }),
                _buildActionButton(Icons.delete, () {
                  _showDeleteConfirmationDialog(index);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFB8500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: const Color(0x66000000),
          elevation: 10,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF023047),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF023047),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        sites.removeAt(index);
                        if (pinnedSiteIndex == index) {
                          pinnedSiteIndex = null;
                        } else if (pinnedSiteIndex != null && pinnedSiteIndex! > index) {
                          pinnedSiteIndex = pinnedSiteIndex! - 1;
                        }
                      });
                      _saveSites();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Color(0xFFFB8500)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFFFB8500)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
