import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
        ),
        title: Text('Profile', style: TextStyle(fontSize: 18),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(CupertinoIcons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/avatar.png', fit: BoxFit.cover, width: 140,), 
              Text('Jessica Souza'),
              Column(
                children: [
                  Text('jessica@gmail.com')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
