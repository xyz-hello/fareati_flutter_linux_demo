import 'package:flutter/material.dart';

void main() {
  runApp(const RideRouteApp());
}

class RideRouteApp extends StatelessWidget {
  const RideRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WELCOME',
      theme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        primaryColor: const Color(0xFF00BFAE), // Teal primary color
        scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Dark background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212), // Dark app bar
          elevation: 4,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF00BFAE), // Primary button color (Teal)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: const Color(0xFF00BFAE), // Teal button color
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(150, 50),
            elevation: 5,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // White body text
          bodyMedium: TextStyle(color: Colors.white70), // Light gray text for secondary info
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Headline
          titleMedium: TextStyle(color: Colors.white70), // Subtitle
        ),
        iconTheme: const IconThemeData(color: Colors.white), // White icons
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xFF333333), // Input field background color
          hintStyle: TextStyle(color: Colors.white70), // Hint text color
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70), // Text field borders
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedFromLocation;
  String? _selectedToLocation;
  bool isSelectingFrom = true;

  final Map<String, double> locationPrices = {
    'MACABALAN': 100.0,
    'S.P.C.': 120.0,
    'PUNTOD': 90.0,
    'MOGCHS': 110.0,
    'DIVISORIA': 105.0,
    'COGON': 95.0,
  };

  void _selectLocation(String location) {
    setState(() {
      if (isSelectingFrom) {
        _selectedFromLocation = location;
      } else {
        _selectedToLocation = location;
      }
    });
  }

  void _resetSelections() {
    setState(() {
      _selectedFromLocation = null;
      _selectedToLocation = null;
    });
  }

  void _showPassengerDialog(int number) {
    if (_selectedFromLocation == null || _selectedToLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both From and To locations.')),
      );
      return;
    }

    double fromPrice = locationPrices[_selectedFromLocation!]!;
    double toPrice = locationPrices[_selectedToLocation!]!;
    double totalCost = number * (fromPrice + toPrice) / 2;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Receipt', style: TextStyle(color: Colors.white)),
        content: Text(
          'From: $_selectedFromLocation\n'
          'To: $_selectedToLocation\n'
          'Passengers: $number\n'
          'Total Fare: \$${totalCost.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButtons(bool isFrom) {
    String? selectedLocation = isFrom ? _selectedFromLocation : _selectedToLocation;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: locationPrices.keys.map((location) {
        bool isSelected = selectedLocation == location;
        return OutlinedButton(
          onPressed: () => _selectLocation(location),
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ? const Color(0xFF00BFAE) : null,
            side: BorderSide(color: isSelected ? const Color(0xFF00BFAE) : Colors.grey),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: Text(location, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }

  Widget _buildPassengerButtons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(9, (index) {
        int number = index + 1;
        return ElevatedButton(
          onPressed: () => _showPassengerDialog(number),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: const CircleBorder(),
            minimumSize: const Size(60, 60),
            backgroundColor: const Color(0xFF00BFAE), // Teal button color
          ),
          child: Text('$number'),
        );
      }),
    );
  }

  Widget _buildSummary() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10, // Example for limited list
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: const Color(0xFF333333), // Dark gray card color
          child: ListTile(
            title: const Text('From → To', style: TextStyle(color: Colors.white)),
            subtitle: const Text('3 passengers — \$150', style: TextStyle(color: Colors.white70)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus, color: Colors.white), // Bus icon
            const SizedBox(width: 8),
            const Text('RideRoute', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh), // Refresh icon for reset
            onPressed: _resetSelections,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              children: [
                ToggleButtons(
                  isSelected: [isSelectingFrom, !isSelectingFrom],
                  onPressed: (index) {
                    setState(() {
                      isSelectingFrom = index == 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: const Color(0xFF00BFAE), // Teal for selected
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('From Location'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('To Location'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Text('From Location:', style: TextStyle(fontSize: 16, color: Colors.white)),
                _buildLocationButtons(true),
                const SizedBox(height: 20),

                const Text('To Location:', style: TextStyle(fontSize: 16, color: Colors.white)),
                _buildLocationButtons(false),
                const SizedBox(height: 20),

                const Text('How many passengers?', style: TextStyle(fontSize: 16, color: Colors.white)),
                _buildPassengerButtons(),
              ],
            ),
            const SizedBox(height: 24),
            if (true) // Conditionally render summary
              const Text('Passengers History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            _buildSummary(),
          ],
        ),
      ),
    );
  }
}
