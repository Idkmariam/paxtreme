import 'package:flutter/material.dart';
import 'studies.dart';
import 'SiteSettings.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String dropdownValue = 'Nebras';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isUsernameEmpty = false;
  bool _isPasswordEmpty = false;
  List<String> options = [
    'Nebras',
    'Dara',
    'Palma',
    'Beta',
    'Hosary',
    'Golf',
    'Dahshour',
    'Kenz',
    'Bedaya'
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF023047),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              _buildLogo(screenHeight),
              SizedBox(height: screenHeight * 0.1), // Increased space here
              _buildCustomDropdown(screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _buildUsernameField(screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _buildPasswordField(screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _buildLoginButton(context, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(double screenHeight) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x8019819E),
            blurRadius: 150,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Image.asset(
        'assets/logo.png',
        height: screenHeight * 0.15,
      ),
    );
  }

  Widget _buildCustomDropdown(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF332B2B),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry<String>> menuItems = [];

          for (var value in options) {
            menuItems.add(
              PopupMenuItem<String>(
                value: value,
                height: 50,
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );

            if (value != options.last) {
              menuItems.add(
                PopupMenuItem<String>(
                  enabled: false,
                  height: 5,
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 1,
                    color: const Color(0xFF023047),
                  ),
                ),
              );
            }
          }

          menuItems.add(
            PopupMenuItem<String>(
              enabled: false,
              child: Container(
                width: 325,
                color: const Color(0xFFCDCDCD),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SiteSettings()),
                    );
                  },
                  child: const Text(
                    'Site settings',
                    style: TextStyle(
                      color: Color(0xFF023047),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          );

          return menuItems;
        },
        constraints: const BoxConstraints(
          maxHeight: 700,
          maxWidth: 300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dropdownValue,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.location_on, color: Color(0xFFFB8500)),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      child: TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          hintText: 'Enter your username',
          hintStyle: const TextStyle(color: Color(0xFF858585)),
          filled: true,
          fillColor: const Color(0xFF332B2B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: _isUsernameEmpty
                ? const BorderSide(color: Colors.red)
                : BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.person, color: Color(0xFFFB8500), size: 30.0),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildPasswordField(double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: const TextStyle(color: Color(0xFF858585)),
          filled: true,
          fillColor: const Color(0xFF332B2B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: _isPasswordEmpty
                ? const BorderSide(color: Colors.red)
                : BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.lock, color: Color(0xFFFB8500), size: 30.0),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.6,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFFB8500),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _isUsernameEmpty = _usernameController.text.isEmpty;
            _isPasswordEmpty = _passwordController.text.isEmpty;
          });

          if (!_isUsernameEmpty && !_isPasswordEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Studies()),
            );
          } else {
            print('Please fill both fields');
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF023047),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
