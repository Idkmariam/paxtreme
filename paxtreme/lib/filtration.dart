import 'package:flutter/material.dart';

class Filtration extends StatefulWidget {
  const Filtration({super.key});

  @override
  State<Filtration> createState() => _FiltrationState();
}

class _FiltrationState extends State<Filtration> {
  String? selectedOption = 'Today';
  final List<String> dropdownItems = [
    'Custom',
    'Today',
    'Yesterday',
    '7 Days ago',
    '30 Days ago',
    'This year',
    'All'
  ];

  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;
  String dateText = '';

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
              'Filtration',
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField('Patient Name', Icons.person),
                const SizedBox(height: 30),
                _buildTextField('Patient ID', Icons.badge),
                const SizedBox(height: 30),
                _buildTextField('Accession#', Icons.confirmation_number),
                const SizedBox(height: 30),
                _buildTextField('Modality', Icons.medical_services),
                const SizedBox(height: 30),
                _buildCustomDropdown(),
                const SizedBox(height: 50),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Apply button pressed with option: $selectedOption');
                      if (selectedDate != null) {
                        print('Selected Date: ${selectedDate!.toString()}');
                      }
                      if (selectedDateRange != null) {
                        print('Selected Date Range: ${selectedDateRange!.start} - ${selectedDateRange!.end}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB8500),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Color(0xFF023047), fontSize: 16),
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

  Widget _buildTextField(String hint, IconData icon) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 45,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: const Color(0xFF332B2B),
          suffixIcon: Icon(
            icon,
            color: const Color(0xFFFB8500),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCustomDropdown() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 45,
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF332B2B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          suffixIcon: Icon(
            Icons.calendar_today,
            color: const Color(0xFFFB8500),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedOption,
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black, fontSize: 17.0),
            items: dropdownItems.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    if (item != dropdownItems.last)
                      const Divider(
                        color: Color(0xFF023047),
                        height: 1,
                        thickness: 1,
                      ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedOption = value;

                if (selectedOption == 'Custom') {
                  _showDateSelectionDialog();
                }
              });
            },
            icon: const SizedBox.shrink(),
            selectedItemBuilder: (BuildContext context) {
              return dropdownItems.map<Widget>((String item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    item == 'Custom' && (selectedDate != null || selectedDateRange != null)
                        ? 'Custom (${dateText.isNotEmpty ? dateText : _formatDate(selectedDate!)})'
                        : item,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showDateSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Would you like to select a specific day or a date range?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showDatePicker();
              },
              child: const Text('Single Day'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showDateRangePicker();
              },
              child: const Text('Date Range'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateText = _formatDate(picked);
      });
    }
  }

  Future<void> _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        dateText = '${_formatDate(picked.start)} - ${_formatDate(picked.end)}';
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
