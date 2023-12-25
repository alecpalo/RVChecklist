import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Trip {
  final String id;
  final DateTime date;
  final List<String> activities;

  Trip({required this.id, required this.date, required this.activities});
}


// Mock data for demonstration purposes
List<Trip> mockTrips = [
  Trip(
    id: '1',
    date: DateTime.now().subtract(Duration(days: 3)),
    activities: ['Hiking', 'Fishing', 'Camping'],
  ),
  Trip(
    id: '2',
    date: DateTime.now().subtract(Duration(days: 30)),
    activities: ['Sightseeing', 'Photography'],
  ),
  // Add more trips as needed
];

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip History'),
        backgroundColor: Colors.blue, // Replace with your color
      ),
      body: ListView.builder(
        itemCount: mockTrips.length,
        itemBuilder: (context, index) {
          Trip trip = mockTrips[index];
          return ListTile(
            title: Text(DateFormat('yyyy-MM-dd').format(trip.date)), // Formatting date
            subtitle: Text('Tap to see details'),
            onTap: () {
              // Navigate to a detailed view of the trip
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripDetails(trip: trip),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TripDetails extends StatelessWidget {
  final Trip trip;

  TripDetails({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip on ${DateFormat('yyyy-MM-dd').format(trip.date)}'),
        backgroundColor: Colors.blue, // Replace with your color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Activities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var activity in trip.activities) Text('• $activity'),
          ],
        ),
      ),
    );
  }
}
