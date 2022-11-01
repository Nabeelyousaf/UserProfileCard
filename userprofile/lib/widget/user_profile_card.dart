import 'package:carousel_slider/carousel_slider.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../model/user_info_model.dart';
import '../provider/user_provider.dart';
import 'custom_image.dart';

// ignore: must_be_immutable
class CustomUserCardView extends StatefulWidget {
  PageController controller;
  CustomUserCardView({
    required this.controller,
    required this.userModel,
  });
  UserModel userModel;

  @override
  State<CustomUserCardView> createState() => _CustomUserCardViewState();
}

class _CustomUserCardViewState extends State<CustomUserCardView> {
  double height = 0.0;
  bool isLike = false;
  bool isDislike = false;
  int _currentindex = 0;
  bool isHideBottomBar = true;
//
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<UserController>(builder: (context, provider, child) {
        return SwipeDetector(
          onSwipeLeft: (value) async {
            Provider.of<UserController>(context, listen: false).showProfile();
            showBottomSheet(userModel: widget.userModel);
          },
          onSwipeRight: (value) {
            Provider.of<UserController>(context, listen: false).showProfile();
            showBottomSheet(userModel: widget.userModel);
          },
          child: GestureDetector(
            onTapDown: (value) {
              var position = value.globalPosition;
              if (position.dy > MediaQuery.of(context).size.height * 0.9) {
                print("vertical");
                Provider.of<UserController>(context, listen: false)
                    .showdislikeButton();
                Future.delayed(Duration(seconds: 1), () {
                  Provider.of<UserController>(context, listen: false)
                      .hideDislikeButton();
                });
              }
            },
            onTapUp: (detail) {
              var position = detail.globalPosition;
              if (position.dx < MediaQuery.of(context).size.width / 2) {
                if (_currentindex == 0) {
                } else {
                  buttonCarouselController.previousPage(
                      curve: Curves.easeInToLinear);
                }
              } else {
                if (_currentindex + 1 != widget.userModel.imageUrl.length) {
                  print("CurrentIndex=NextPage" + _currentindex.toString());
                  buttonCarouselController.nextPage(
                      curve: Curves.easeInToLinear);
                }
              }
            },
            onTap: () {},
            onDoubleTap: () {
              Provider.of<UserController>(context, listen: false).showLike();
              Future.delayed(Duration(seconds: 1), () {
                Provider.of<UserController>(context, listen: false).hideLike();
              });
              // print("DoubleTab1111");
            },
            child: Stack(
              fit: StackFit.loose,
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  items: widget.userModel.imageUrl.map((e) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            e,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                      pauseAutoPlayInFiniteScroll: true,
                      height: MediaQuery.of(context).size.height,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      onPageChanged: (inde, value) {
                        _currentindex = inde;
                        setState(() {});
                      }),
                ),
                Container(
                  height: height,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: kToolbarHeight,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomImageButton(
                                  image: widget.userModel.imageUrl[0]),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/chat.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              if (provider.islIke == true)
                                Lottie.asset(
                                  'assets/heart.json',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              if (provider.disLikeButton == true)
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 70,
                                  ),
                                )
                            ]),
                          ),
                        ),
                        if (provider.isHideProfile == false)
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kBottomNavigationBarHeight + 20),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Provider.of<UserController>(context,
                                              listen: false)
                                          .showProfile();
                                      showBottomSheet(
                                          userModel: widget.userModel);
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          widget.userModel.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          widget.userModel.age,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          widget.userModel.userHeight,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                            // "AD"
                                            child: Flag.fromString(
                                                widget.userModel.countryFlag,
                                                height: 20,
                                                width: 50,
                                                fit: BoxFit.fill)),
                                      ),
                                      Container(
                                        height: 10,
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          widget.userModel.distance,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            // fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  showBottomSheet({required UserModel userModel}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              Provider.of<UserController>(context, listen: false).hideProfile();
              return true;
            },
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            userModel.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            userModel.age,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              // fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              userModel.userHeight,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                // fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 1,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                child: Flag.fromString(userModel.countryFlag,
                                    height: 20, width: 50, fit: BoxFit.fill)),
                          ),
                          Container(
                            height: 10,
                            width: 1,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              userModel.distance,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                // fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Religion: ${userModel.religion}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Professional: ${userModel.professional}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "About Me: ${userModel.description}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          // fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomInfoIcon(image: "assets/diamond.png"),
                              SizedBox(
                                width: 20,
                              ),
                              CustomInfoIcon(image: "assets/check-mark.png"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CustomInfoIcon extends StatelessWidget {
  final String image;
  const CustomInfoIcon({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
    );
  }
}
