import 'dart:ui';
import 'package:basic_game/component/player.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class GameController extends Game{
  Size screenSize;
  double tileSize;
  Player player;

  GameController(){
    initialize();
  }

  void initialize() async{
    resize(await Flame.util.initialDimensions());
    player = Player(this);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color =  Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);
    player.render(c);
  }

  void update(double t) {
    
  }

  void resize(Size size){
    screenSize = size;
    tileSize =screenSize.width/10;
  }
}