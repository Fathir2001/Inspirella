// NextPage.dart

import 'package:flutter/material.dart';
import 'package:inspirella/pages/HomePage.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final List<Map<String, dynamic>> moods = [
    {
      'emoji': '😊',
      'mood': 'Happy',
      'color': Colors.yellow[200],
    },
    {
      'emoji': '😔',
      'mood': 'Sad',
      'color': Colors.blue[200],
    },
    {
      'emoji': '😌',
      'mood': 'Calm',
      'color': Colors.green[200],
    },
    {
      'emoji': '😤',
      'mood': 'Angry',
      'color': Colors.red[200],
    },
    {
      'emoji': '🥰',
      'mood': 'Love',
      'color': Colors.pink[200],
    },
  ];

  int selectedMoodIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple.shade100, Colors.blue.shade100],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "How are you feeling today?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 500 + (index * 200)),
                      builder: (context, double value, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMoodIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: selectedMoodIndex == index
                                ? moods[index]['color']
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                moods[index]['emoji'],
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(width: 20),
                              Text(
                                moods[index]['mood'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              if (selectedMoodIndex == index)
                                Icon(Icons.check_circle,
                                    color: Colors.green.shade700),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: selectedMoodIndex != -1 ? 1.0 : 0.0,
                  child: ElevatedButton(
                    onPressed: selectedMoodIndex != -1
                        ? () {
                            // Navigate to main app
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(mood: moods[selectedMoodIndex]['mood']),
                              ),
                            );
                          }
                        : null,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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
}