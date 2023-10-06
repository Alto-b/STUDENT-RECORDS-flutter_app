// import 'dart:html';

// import 'package:flutter/material.dart';

// class Fab extends StatefulWidget {
//   const Fab({super.key, required this.children, required this.distance});

//   final List<Widget> children;
//   final double distance;

//   @override
//   State<Fab> createState() => _FabState();
// }

// class _FabState extends State<Fab> with SingleTickerProviderStateMixin {
 
//  late AnimationController _controller;
//  late Animation<double> _expandAnimation;
//  bool _open=false;

//   @override

// void initState(){
//   super.initState();

//   _controller=AnimationController(
//     value: _open ? 1.0:0.0,
//     duration: const Duration(milliseconds:250),
//     vsync:this );

//     _expandAnimation=CurvedAnimation(

//     )
// }

//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }