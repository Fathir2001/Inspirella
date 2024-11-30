// home_page.dart

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  final String mood;
  
  HomePage({required this.mood});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, List<String>> moodQuotes = {
    'Happy': [
      "The simplest things in life bring the greatest joy.",
      "Happiness is not something ready-made. It comes from your own actions.",
      "Smile, it's free therapy.",
    ],
    'Sad': [
      "Even the darkest night will end and the sun will rise.",
      "Pain makes you stronger, tears make you braver.",
      "Every storm runs out of rain.",
    ],
    'Calm': [
      "Peace comes from within.",
      "Breathe in peace, breathe out stress.",
      "Stillness is where creativity and solutions are found.",
    ],
    'Angry': [
      "Anger is a valid emotion, but a poor master.",
      "The greatest remedy for anger is delay.",
      "Count to ten and breathe deeply.",
    ],
    'Love': [
      "Love yourself first and everything else falls into line.",
      "Where there is love there is life.",
      "The best thing to hold onto in life is each other.",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Current Mood: ",
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              "${widget.mood}",
              style: TextStyle(
                color: Colors.purple.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black87),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.purple.shade50],
          ),
        ),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return _buildQuoteCard(moodQuotes[widget.mood]![index]);
          },
          itemCount: moodQuotes[widget.mood]!.length,
          layout: SwiperLayout.TINDER,
          itemWidth: MediaQuery.of(context).size.width * 0.85,
          itemHeight: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }

  Widget _buildQuoteCard(String quote) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                _getMoodColor(widget.mood).withOpacity(0.3),
              ],
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getMoodIcon(widget.mood),
                size: 60,
                color: _getMoodColor(widget.mood),
              ),
              SizedBox(height: 30),
              Text(
                quote,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.yellow.shade600;
      case 'Sad':
        return Colors.blue.shade400;
      case 'Calm':
        return Colors.green.shade400;
      case 'Angry':
        return Colors.red.shade400;
      case 'Love':
        return Colors.pink.shade400;
      default:
        return Colors.purple.shade400;
    }
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_very_satisfied;
      case 'Sad':
        return Icons.sentiment_very_dissatisfied;
      case 'Calm':
        return Icons.spa;
      case 'Angry':
        return Icons.mood_bad;
      case 'Love':
        return Icons.favorite;
      default:
        return Icons.mood;
    }
  }
}