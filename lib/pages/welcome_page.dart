// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/aboutus_page.dart';
import 'package:flutter_application_1/pages/accounts_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/shop_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SamsungSharpSans',
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _controller;
  Timer? _timer;
  int _currentPageIndex = 0;
final String contactUrl='https://linktr.ee/amconline';
final String emailUrl="https://www.google.com/gmail";
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    const Duration duration = Duration(seconds: 3); // Adjust the duration as needed
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_controller.hasClients) {
        if (_currentPageIndex < imageGroups.length - 1) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
        _controller.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void launchWhatsApp({required String phone, required String message}) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    try {
      if (await canLaunchUrl(url() as Uri)) {
        await launchUrl(url() as Uri);
      } else {
        throw 'Could not launch ${url()}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Could not launch WhatsApp Link: $e');
      }
    }
  }

  // ignore: unused_element
  void _launchURL(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<List<String>> imageGroups = [
    [
      'images/AXLE SLIDERS BANNER.png',
      'images/BARPADLAPTIMER BANNER.png',
      'images/OVERFLOW BOTTLE BANNER.png',
    ],
    [
      'images/FOOTPEG BANNER.png',
      'images/GEAR RACK BANNER.png',
      'images/SHIFT BOOT BANNER.png',
    ],
    // You can add more image groups here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Welcome',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Shop'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Contact Us'),
              onTap: () {
                launchUrl(Uri.parse(contactUrl));
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Fitment Sheet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
         // image: DecorationImage(
            //image: AssetImage('images/Backgroun'),
           // fit: BoxFit.cover,
         // ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 400, // Adjust the height as needed to make the images bigger
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'images/BackgroundAmc.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  PageView.builder(
                    controller: _controller,
                    itemCount: imageGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: imageGroups[index].map((path) {
                          return Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                               // border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Image.asset(
                                path,
                                fit: BoxFit.cover, // Adjust the fit to cover the entire container
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Positioned(
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 50, color: Colors.black),
                      onPressed: () {
                        if (_controller.hasClients) {
                          _controller.animateToPage(
                            max((_controller.page! - 1).toInt(), 0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 50, color: Colors.black),
                      onPressed: () {
                        if (_controller.hasClients) {
                          _controller.animateToPage(
                            min((_controller.page! + 1).toInt(), imageGroups.length - 1),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopPage(),
                  ),
                );
              },
              child: const Text('Go to Shop'),
            ),
            const SizedBox(height: 40),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'images/low_res_amc-removebg-preview.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color of the container
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Motorsports Store',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Motorsport is our canvas, and innovation is our paintbrush... Watch this space!',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Does it fit your bike?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'For any enquiries or questions',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          'email us at advancedmotorsportcomponent@gmail.com' ,
                          style: TextStyle(fontSize: 16),
                          ),
              
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.mail, color: Colors.black),
                          onPressed: () async {
                                String email = Uri.encodeComponent("AdvancedMotorsportComponent@gmail.com");
                                String subject = Uri.encodeComponent("Will [Product name] fit on my bike?");
                                String body = Uri.encodeComponent("Hi! I'm wondering if [Product name] will fit on [Your bike]");
                               if (kDebugMode) {
                                 print(subject);
                               } //output: Hello%20Flutter
                            //  String url = 'mailto:$email?subject=$subject&body=$body';
                      if (await canLaunchUrlString('mailto:$email?subject=$subject&body=$body')) {
                           launchUrl(Uri.parse(emailUrl));
                      }else{
                          //email app is not opened
                      }
                              },
                            ),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

