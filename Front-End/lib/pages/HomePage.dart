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
      "Happiness is when what you think, what you say, and what you do are in harmony.",
      "The most wasted of all days is one without laughter.",
      "Happiness is not something ready-made. It comes from your own actions.",
      "Don't worry, be happy!",
    ],
    'Sad': [
      "Even the darkest night will end and the sun will rise.",
      "Pain makes you stronger, tears make you braver, heartbreak makes you wiser.",
      "Every storm runs out of rain.",
      "Behind every cloud is another cloud with a silver lining.",
      "Tears are words the heart can't express.",
    ],
    'Calm': [
      "Peace comes from within. Do not seek it without.",
      "Breathe in peace, breathe out stress.",
      "Stillness is where creativity and solutions are found.",
      "The calm mind is the ultimate weapon against your challenges.",
      "In the midst of movement and chaos, keep stillness inside of you.",
    ],
    'Angry': [
      "Anger is a valid emotion, but a poor master.",
      "The greatest remedy for anger is delay.",
      "For every minute you are angry you lose sixty seconds of happiness.",
      "Speak when you are angry and you will make the best speech you will ever regret.",
      "When angry, count to ten before you speak.",
    ],
    'Love': [
      "Love yourself first and everything else falls into line.",
      "Where there is love there is life.",
      "The best thing to hold onto in life is each other.",
      "Love is not what you say. Love is what you do.",
      "The greatest happiness of life is the conviction that we are loved.",
    ],
    'Thoughtful': [
      "The world as we have created it is a process of our thinking.",
      "Those who know how to think need no teachers.",
      "Think before you speak. Read before you think.",
      "The mind is everything. What you think you become.",
      "Thinking is difficult, that's why most people judge.",
    ],
    'Confident': [
      "Confidence is not 'they will like me'. It's 'I'll be fine if they don't'.",
      "Your success will be determined by your own confidence and fortitude.",
      "When you have confidence, you can have a lot of fun.",
      "Confidence comes not from always being right but from not fearing to be wrong.",
      "Self-confidence is the first requisite to great undertakings.",
    ],
    'Excited': [
      "Life is either a daring adventure or nothing at all.",
      "Adventure is worthwhile in itself.",
      "Get excited about the little things, because one day you'll look back and realize they were the big things.",
      "Follow your excitement. It's the universe showing you your next step.",
      "Life is short. Do stuff that matters. Do stuff that's exciting.",
    ],
    'Tired': [
      "Rest when you're weary. Refresh and renew yourself, your body, your mind, your spirit.",
      "Sometimes the most productive thing you can do is rest.",
      "Your body is telling you it needs a break. Listen to it.",
      "Sleep is the best meditation.",
      "Even the strongest minds need rest.",
    ],
    'Anxious': [
      "Anxiety does not empty tomorrow of its sorrows, but only empties today of its strength.",
      "Trust yourself. You've survived a lot, and you'll survive whatever is coming.",
      "Don't believe every worried thought you have. Worried thoughts are notoriously inaccurate.",
      "Take life day by day and be gentle with yourself.",
      "Anxiety is like a rocking chair. It gives you something to do but never gets you anywhere.",
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