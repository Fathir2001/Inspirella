import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math' as math;
import './NextPage.dart';

class FloatingEmoji extends StatefulWidget {
  final String emoji;
  final double startX;
  final double startY;

  FloatingEmoji({required this.emoji, required this.startX, required this.startY});

  @override
  _FloatingEmojiState createState() => _FloatingEmojiState();
}

class _FloatingEmojiState extends State<FloatingEmoji> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _randomOffset;

  @override
  void initState() {
    super.initState();
    _randomOffset = math.Random().nextDouble() * 2 * math.pi;
    _controller = AnimationController(
      duration: Duration(seconds: 3 + math.Random().nextInt(4)),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.startX + 30 * math.sin(_controller.value * 2 * math.pi + _randomOffset),
          top: widget.startY - 100 * _controller.value,
          child: Opacity(
            opacity: 1 - _controller.value,
            child: Text(
              widget.emoji,
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final List<String> _emojis = [
  '😊', '😄', '😃', '🥰','😢', '😥','🥺', '😔','🤩','😌','😠', '😤','😫', '😪', '😮‍💨', '🥱'
];
  final List<Widget> _floatingEmojis = [];

  void _addEmoji() {
    if (!mounted) return;
    setState(() {
      _floatingEmojis.add(
        FloatingEmoji(
          emoji: _emojis[math.Random().nextInt(_emojis.length)],
          startX: math.Random().nextDouble() * 300,
          startY: math.Random().nextDouble() * 800,
        ),
      );
    });
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _floatingEmojis.removeAt(0);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // Start adding emojis periodically
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      _addEmoji();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A237E),  // Deep purple
                  Color(0xFF7C4DFF),  // Purple accent
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Icon(
                          Icons.psychology,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 10),
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Inspirella',
                                textStyle: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                                speed: Duration(milliseconds: 200),
                              ),
                            ],
                            repeatForever: true,
                            pause: Duration(milliseconds: 1000),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Find quotes that match your mood',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  NextPage(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.purple.shade300,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ..._floatingEmojis,
        ],
      ),
    );
  }
}