import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About AMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const <Widget>[
            Text(
              'ABOUT AMC (Advanced Motorsport Components)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Founded in 2022, AMC (Advanced Motorsport Components) is a dynamic South African business specializing in the sale and manufacturing of high-quality bike equipment tailored specifically for Motards. We take pride in designing and producing a wide range of products, including axel sliders, footpeg sliders, timer mounts, gear racks, and much more.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'At AMC, we understand the needs and demands of passionate Motard enthusiasts who crave exceptional performance and durability. That\'s why we offer two distinct product lines: AMC Velocity and AMC Apex. These lines are designed to cater to varying preferences and budgets, ensuring that every rider can find the perfect fit for their specific requirements.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'AMC Apex represents the pinnacle of our craftsmanship. Meticulously engineered using state-of-the-art technology and premium materials, these products exemplify the highest standards of quality and performance. The AMC Apex line is tailored for those who demand nothing but the absolute best, providing an unrivaled experience on the track or the street.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'For riders seeking exceptional value without compromising on quality, our AMC Velocity line offers an impressive range of products. While still maintaining our commitment to durability and functionality, AMC Velocity caters to a wider audience, providing accessible options for Motard enthusiasts looking to enhance their riding experience within a more affordable range.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'At AMC, we believe in going beyond customer satisfaction. We are passionate riders ourselves, and we understand the importance of reliable equipment for an exhilarating and safe riding experience. That\'s why we continuously strive to push the boundaries of innovation, staying ahead of the curve to deliver cutting-edge products that meet the evolving needs of the motorsport community.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'With a dedicated team of skilled professionals and a commitment to excellence, AMC is proud to be a trusted name in the industry. We work closely with riders, dealers, and distributors to ensure that our products not only meet but exceed expectations. Whether you\'re a professional racer or a weekend warrior, AMC is here to provide you with the finest motorsport components that will elevate your performance and fuel your passion.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Choose AMC (Advanced Motorsport Components) for unmatched quality, reliability, and innovation in Motard equipment. Experience the thrill of riding with confidence and explore new limits with our meticulously crafted products. We are committed to delivering excellence, every time.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Discover the power of AMC Velocity and the unrivaled performance of AMC Apex – where quality meets passion, and precision drives success.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
