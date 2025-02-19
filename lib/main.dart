import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(
            child: const Text(
              'NO JEETS IN MY BALANCE SHEETS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: const ExpandingImageAnimation(
          imagePath: 'assets/images/pajeet.png',
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLinkButton(
                  'assets/images/pf.jpg',
                  'https://pump.fun/coin/71sxK8UWUeNDQhSzALAPvurYutW1Jncr2UshjjP1pump',
                ),
                buildLinkButton(
                  'assets/images/x.png',
                  'https://x.com/ExcuseMeNoJeets',
                ),
                buildLinkButton(
                  'assets/images/dex.png',
                  'https://dexscreener.com',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLinkButton(String assetPath, String url) {
    return IconButton(
      icon: Image.asset(assetPath),
      onPressed: () => _launchURL(url),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ExpandingImageAnimation extends StatefulWidget {
  final String imagePath;

  const ExpandingImageAnimation({super.key, required this.imagePath});

  @override
  State<ExpandingImageAnimation> createState() =>
      _ExpandingImageAnimationState();
}

class _ExpandingImageAnimationState extends State<ExpandingImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Adjust animation duration here
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.05,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation automatically
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Expanding image
        Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final screenSize = MediaQuery.of(context).size;
              final maxWidth = screenSize.width;
              final maxHeight =
                  screenSize.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight + 50);

              return SizedBox(
                width: maxWidth * _animation.value,
                height: maxHeight * _animation.value,
                child: Image.asset(widget.imagePath, fit: BoxFit.cover),
              );
            },
          ),
        ),
      ],
    );
  }
}
