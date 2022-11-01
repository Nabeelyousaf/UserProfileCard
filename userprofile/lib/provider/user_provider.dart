import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  bool _isHideProfile = false;
  bool _islike = false;
  bool _dislike = false;

  void showProfile() {
    _isHideProfile = true;
    notifyListeners();
  }

  void hideProfile() {
    _isHideProfile = false;
    notifyListeners();
  }

  void showLike() {
    _islike = true;
    notifyListeners();
  }

  void hideLike() {
    _islike = false;
    notifyListeners();
  }

  void showdislikeButton() {
    _dislike = true;
    notifyListeners();
  }

  void hideDislikeButton() {
    _dislike = false;
    notifyListeners();
  }

  bool get isHideProfile => _isHideProfile;
  bool get islIke => _islike;
  bool get disLikeButton => _dislike;
}
