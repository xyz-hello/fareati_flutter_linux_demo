import 'package:flutter/material.dart';
import '../widgets/location_selection.dart';
import '../widgets/passenger_buttons.dart';
import 'success_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _fromLocation;
  String? _toLocation;
  bool _isSelectingFrom = true;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _passengerRecords = [];

  final Map<String, double> _locationPrices = {
    'MACABALAN': 100.0,
    'S.P.C.': 120.0,
    'PUNTOD': 90.0,
    'MOGCHS': 110.0,
    'DIVISORIA': 105.0,
    'COGON': 95.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DESTINATIONS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                LocationSelection(
                  locations: _locationPrices.keys.toList(),
                  selectedFrom: _fromLocation,
                  selectedTo: _toLocation,
                  isSelectingFrom: _isSelectingFrom,
                  onSelectFrom: () => setState(() => _isSelectingFrom = true),
                  onSelectTo: () => setState(() => _isSelectingFrom = false),
                  onEndShift: _showEndShiftDialog,
                  onLocationPressed: _selectLocation,
                ),
                const SizedBox(height: 20),
                const Text(
                  'How many passengers?',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                PassengerButtons(onPressed: _showPassengerDialog),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  void _selectLocation(String location) {
    setState(() {
      if (_isSelectingFrom) {
        _fromLocation = location;
        _isSelectingFrom = false;
      } else {
        _toLocation = location;
      }
    });
  }

  void _resetSelections() => setState(() {
    _fromLocation = null;
    _toLocation = null;
    _isSelectingFrom = true;
  });

  void _showPassengerDialog(int number) {
    if (_fromLocation == null || _toLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select both a starting and destination location.',
          ),
        ),
      );
      return;
    }

    final fromPrice = _locationPrices[_fromLocation!]!;
    final toPrice = _locationPrices[_toLocation!]!;
    final totalCost = number * (fromPrice + toPrice) / 2;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Receipt', style: TextStyle(color: Colors.white)),
            content: Text(
              'Number of Passengers: $number\nFrom: $_fromLocation\nTo: $_toLocation\nTotal Cost: \$$totalCost',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: Colors.black,
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _passengerRecords.add({
                      'from': _fromLocation,
                      'to': _toLocation,
                      'passengers': number,
                      'cost': totalCost,
                    });
                  });
                  Navigator.pop(context);
                  _resetSelections();
                },
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _showEndShiftDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Enter PIN'),
            content: TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'PIN'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.text == '1234') {
                    Navigator.pop(context);
                    _endShift();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Incorrect PIN')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  Future<void> _endShift() async {
    setState(() => _isLoading = true);

    // Simulate a network delay instead of calling ApiService
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to SuccessPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuccessPage()),
    );

    setState(() => _isLoading = false);
  }
}
