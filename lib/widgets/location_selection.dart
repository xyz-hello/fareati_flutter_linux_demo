// import 'package:flutter/material.dart';

// class LocationSelection extends StatelessWidget {
//   final List<String> locations; // List of all locations to display
//   final String? selectedFrom; // Currently selected starting location
//   final String? selectedTo; // Currently selected destination
//   final bool isSelectingFrom; // Flag to know which button is active
//   final VoidCallback onSelectFrom; // Callback for "Select Starting Location"
//   final VoidCallback onSelectTo; // Callback for "Select Destination Location"
//   final VoidCallback onEndShift; // Callback for "End Shift"
//   final Function(String)
//   onLocationPressed; // Callback when a location button is pressed

//   const LocationSelection({
//     super.key,
//     required this.locations,
//     this.selectedFrom,
//     this.selectedTo,
//     required this.isSelectingFrom,
//     required this.onSelectFrom,
//     required this.onSelectTo,
//     required this.onEndShift,
//     required this.onLocationPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Top row: Selection buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: onSelectFrom,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//                 backgroundColor: isSelectingFrom ? Colors.green : Colors.blue,
//               ),
//               child: const Text('Select Starting Location'),
//             ),
//             const SizedBox(width: 20),
//             ElevatedButton(
//               onPressed: onSelectTo,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//                 backgroundColor: !isSelectingFrom ? Colors.green : Colors.blue,
//               ),
//               child: const Text('Select Destination Location'),
//             ),
//             const SizedBox(width: 20),
//             ElevatedButton(
//               onPressed: onEndShift,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//                 backgroundColor: Colors.red,
//               ),
//               child: const Text('End Shift'),
//             ),
//           ],
//         ),

//         const SizedBox(height: 20),

//         // Horizontal scroll of location buttons
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children:
//                 locations.map((location) {
//                   final isDisabled =
//                       selectedFrom == location || selectedTo == location;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: ElevatedButton(
//                       onPressed:
//                           isDisabled ? null : () => onLocationPressed(location),
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 15,
//                         ),
//                         backgroundColor: isDisabled ? Colors.grey : Colors.blue,
//                       ),
//                       child: Text(
//                         location,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
