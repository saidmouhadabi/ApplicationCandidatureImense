import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  // Declaration var
  String selectedSite = "Site 001";
  String selectedZone = "Zone 001";
  int selectedLevel = 2;
  String selectedRoom = "Room 1.02";
  String selectedPosition = "Inside";
  String selectedTime = "60 Minutes";
  bool isZoneFavorited = false;
  bool isSaved = false; // Variable to track the save state
  int selectedButtonIndex = 0; // Variable to track the selected button index for Room and Equipment
  int selectedPositionIndex = 0; // Variable to track the selected button index for Inside and Outside
  final PageController _pageController = PageController(viewportFraction: 0.3);
  List<String> rooms = ['Room 1.02', 'Room 1.03', 'Room 1.04']; // List of rooms

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Alert'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard_return_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionHeader("Site"),
              SizedBox(height: 8),
              buildDropdownButton(
                value: selectedSite,
                items: ['Site 001', 'Site 002', 'Site 003'],
                onChanged: (newValue) {
                  setState(() {
                    selectedSite = newValue!;
                  });
                },
                isFavorite: isSaved,
                onFavoriteToggle: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
              ),
              SizedBox(height: 16),
              buildSectionHeader("Zone"),
              SizedBox(height: 8),
              buildDropdownButton(
                value: selectedZone,
                items: ['Zone 001', 'Zone 002', 'Zone 003'],
                onChanged: (newValue) {
                  setState(() {
                    selectedZone = newValue!;
                  });
                },
                isFavorite: isZoneFavorited,
                onFavoriteToggle: () {
                  setState(() {
                    isZoneFavorited = !isZoneFavorited;
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Level'),
              SizedBox(height: 8),
              buildLevelSelector(),
              SizedBox(height: 16),
              buildLocationSelector(),
              SizedBox(height: 16),
              buildRoomSelector(),
              SizedBox(height: 16),
              buildPositionSelector(),
              SizedBox(height: 16),
              Text(
                'Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedTime,
                decoration: InputDecoration(
                  labelText: 'Time expected to complete the job',
                  border: OutlineInputBorder(),
                ),
                items: List.generate(12, (index) {
                  int minutes = (index + 1) * 5;
                  return DropdownMenuItem<String>(
                    value: '${minutes} Minutes',
                    child: Text('${minutes} Minutes'),
                  );
                }),
                onChanged: (newValue) {
                  setState(() {
                    selectedTime = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.send_rounded, color: Colors.white,),
                  label: Text(
                    'Send alert',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Icon(Icons.error, color: Colors.grey),
      ],
    );
  }

  Widget buildDropdownButton({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              color: isFavorite ? Colors.yellow : Colors.grey,
              onPressed: onFavoriteToggle,
            ),
          ],
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget buildLevelSelector() {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 13,
                itemBuilder: (context, index) {
                  final int level = index - 2;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLevel = level;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selectedLevel == level
                            ? Colors.purple
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        level.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedLevel == level
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLocationSelector() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedButtonIndex = 0; // Sélectionne le bouton "Room"
              });
            },
            child: Text(
              'Room',
              style: TextStyle(
                color: selectedButtonIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedButtonIndex == 0 ? Colors.purple : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedButtonIndex = 1; // Sélectionne le bouton "Equipment"
              });
            },
            child: Text(
              'Equipment',
              style: TextStyle(
                color: selectedButtonIndex == 1 ? Colors.white : Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedButtonIndex == 1 ? Colors.purple : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRoomSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Room',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () {
            // Logic to add new room
            _showAddRoomDialog();
          },
          child: Row(
            children: [
              Icon(Icons.add, size: 20),
              SizedBox(width: 4),
              Text('Add'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPositionSelector() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedPositionIndex = 0; // Sélectionne le bouton "Inside"
                selectedPosition = "Inside";
              });
            },
            child: Text(
              'Inside',
              style: TextStyle(
                color: selectedPositionIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedPositionIndex == 0 ? Colors.purple : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedPositionIndex = 1; // Sélectionne le bouton "Outside"
                selectedPosition = "Outside";
              });
            },
            child: Text(
              'Outside',
              style: TextStyle(
                color: selectedPositionIndex == 1 ? Colors.white : Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedPositionIndex == 1 ? Colors.purple : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ],
    );
  }

  // Function to show a dialog for adding a new room
  void _showAddRoomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController roomController = TextEditingController();

        return AlertDialog(
          title: Text(
            'Add New Room',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: roomController,
            decoration: InputDecoration(
              hintText: 'Enter room name',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  rooms.add(roomController.text);
                  selectedRoom = roomController.text; // Select the new room
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
