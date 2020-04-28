import 'package:basic_game/game_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  
  
  Timer(Duration(seconds:10),(){
    
    runApp(gameController.widget);
  });

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown=gameController.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
  
}

