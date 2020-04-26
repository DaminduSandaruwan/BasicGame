import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class GameController extends Game{
  Size screenSize;
  double tileSize;

  GameController(){
    initialize();
  }

  void initialize() async{
    resize(await Flame.util.initialDimensions());
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTRB(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color =  Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);
  }

  void update(double t) {
    
  }

  void resize(Size size){
    screenSize = size;
    tileSize =screenSize.width/10;
  }
}