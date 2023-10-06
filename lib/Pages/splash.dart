// import 'package:flutter/material.dart';
// import 'package:student_records/Pages/homepage.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();

//     // This is where you can add any additional initialization logic if needed.
//     // For example, you can load data or perform other tasks.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         // Animated start
//         child: Image.network(
//           'https://cdn.dribbble.com/users/722246/screenshots/4400319/media/8854b69f794471a100c85577859e9c5e.gif',
//           width: 500,
//           height: 500,
//         ),
//         // Animated end
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Homepage()));
//     });
//   }
// }
