// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:io';

class DetailsPage extends StatefulWidget {
  final String name;
  final int contact;
  final String domain;
  final String? imagePath;

  const DetailsPage(
      {super.key, required this.name,
      required this.contact,
      required this.domain,
      this.imagePath});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 90,
              backgroundImage: widget.imagePath != null
                  ? FileImage(File(widget.imagePath!))
                  : null,
              child: widget.imagePath == null
                  ? Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Name : ${widget.name}",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: Icon(Icons.class_outlined),
            title: Text("domain : ${widget.domain}",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Contact : ${widget.contact}",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
          ),
         
        ],
      ),
    );
  }
}