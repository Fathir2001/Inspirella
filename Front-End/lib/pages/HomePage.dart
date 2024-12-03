// home_page.dart

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String mood;
  
  HomePage({required this.mood});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<String>> moodQuotes = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    try {
      final String response = await rootBundle.loadString('assets/quotes.json');
      final data = await json.decode(response);
      setState(() {
        moodQuotes = Map<String, List<String>>.from(
          data.map((key, value) => MapEntry(
            key,
            List<String>.from(value),
          )),
        );
        isLoading = false;
      });
    } catch (e) {
      print('Error loading quotes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Text(
              "Current Mood: ",
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              "${widget.mood}",
              style: TextStyle(
                color: _getMoodColor(widget.mood),
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : moodQuotes.isEmpty
                ? Center(
                    child: Text('Failed to load quotes'),
                  )
                : Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildQuoteCard(
                          moodQuotes[widget.mood]?[index] ?? "No quote available");
                    },
                    itemCount: moodQuotes[widget.mood]?.length ?? 0,
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
      case 'Happy': return Colors.yellow.shade600;
      case 'Sad': return Colors.blue.shade400;
      case 'Calm': return Colors.green.shade400;
      case 'Angry': return Colors.red.shade400;
      case 'Love': return Colors.pink.shade400;
      case 'Thoughtful': return Colors.indigo.shade400;
      case 'Confident': return Colors.teal.shade400;
      case 'Excited': return Colors.orange.shade400;
      case 'Tired': return Colors.grey.shade400;
      case 'Anxious': return Colors.purple.shade400;
      default: return Colors.purple.shade400;
    }
  }

  IconData _getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy': return Icons.sentiment_very_satisfied;
      case 'Sad': return Icons.sentiment_very_dissatisfied;
      case 'Calm': return Icons.spa;
      case 'Angry': return Icons.mood_bad;
      case 'Love': return Icons.favorite;
      case 'Thoughtful': return Icons.psychology;
      case 'Confident': return Icons.star;
      case 'Excited': return Icons.celebration;
      case 'Tired': return Icons.bedtime;
      case 'Anxious': return Icons.warning_amber;
      default: return Icons.mood;
    }
  }
}