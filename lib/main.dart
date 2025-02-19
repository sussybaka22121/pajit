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
          title: const Text('My Static Website'),
          actions: [
            _buildLinkButton('assets/images/x.png', 'https://twitter.com'),
            _buildLinkButton('assets/images/tg.png', 'https://telegram.org'),
            _buildLinkButton(
              'assets/images/dex.png',
              'https://dexscreener.com',
            ),
            _buildLinkButton('assets/images/pf.jpg', 'https://pump.fun'),
          ],
        ),
        backgroundColor: Colors.white,
        body: const Center(
          child: Text(
            'Welcome to My Static Website!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: SizedBox(height: 50),
        ),
      ),
    );
  }

  Widget _buildLinkButton(String assetPath, String url) {
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
