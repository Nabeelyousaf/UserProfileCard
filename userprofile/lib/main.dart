import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userprofile/model/user_info_model.dart';
import 'provider/user_provider.dart';
import 'widget/user_profile_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserController>(
      create: (_) => UserController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: UserProfileCard(),
      ),
    );
  }
}

class UserProfileCard extends StatefulWidget {
  UserProfileCard({super.key});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  bool pageIsScrolling = false;
  final List<UserModel> userModel = [
    UserModel(
      age: "25",
      countryFlag: "PK",
      distance: "125 Mile",
      imageUrl: [
        "assets/girl.jpg",
        "assets/image1.jpg",
        "assets/image2.jpg",
        "assets/image3.jpg"
      ],
      name: "Angela",
      userHeight: "5.6",
      description: "",
      professional: " ",
      religion: "",
    ),
    UserModel(
        age: "25",
        countryFlag: "IN",
        distance: "125 Mile",
        imageUrl: ["assets/image1.jpg"],
        name: "Jani",
        description: "",
        professional: " ",
        religion: "",
        userHeight: "5.6"),
    UserModel(
        age: "25",
        countryFlag: "IN",
        distance: "125 Mile",
        description: "",
        professional: " ",
        religion: "",
        imageUrl: ["assets/image2.jpg"],
        name: "Jani",
        userHeight: "5.6"),
    UserModel(
        age: "25",
        countryFlag: "IN",
        distance: "125 Mile",
        description: "",
        professional: " ",
        religion: "",
        imageUrl: ["assets/image3.jpg"],
        name: "Jani",
        userHeight: "5.6"),
    UserModel(
        age: "25",
        countryFlag: "IN",
        distance: "125 Mile",
        description: "",
        professional: " ",
        religion: "",
        imageUrl: ["assets/image1.jpg"],
        name: "Jani",
        userHeight: "5.6")
  ];

  PageController pageController = PageController();
  bool isDislike = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: PageController(viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemCount: userModel.length,
          itemBuilder: (context, index) {
            return AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return SlideTransition(
                    child: child,
                    position:
                        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                            .animate(animation));
              },
              duration: Duration(milliseconds: 200),

              child: CustomUserCardView(
                controller: pageController,
                userModel: userModel[index],
              ),
              // ),
            );
          },
        )
        // body: CustomUserCardView(),
        );
  }
}
