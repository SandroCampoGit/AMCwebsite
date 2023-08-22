import 'package:flutter/material.dart';

class FitmentSheetPage extends StatelessWidget {
  const FitmentSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('AMC FITMENT SHEET'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *2,
              height: MediaQuery.of(context).size.height * 5, // You can adjust the height as needed
              child: Image.asset(
                'images/FITMENT LIST.png', // Replace this URL with the actual image URL
               // fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
