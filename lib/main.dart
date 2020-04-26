import 'package:basic_game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

void main() async {
  

  GameController gameController = GameController();
  WidgetsFlutterBinding.ensureInitialized();
  Timer(Duration(seconds:10),(){
    
    runApp(gameController.widget);
  });

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  
}

