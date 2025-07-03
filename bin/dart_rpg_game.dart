import 'package:dart_rpg_game/dart_rpg_game.dart' as dart_rpg_game;
import 'package:dart_rpg_game/game.dart';
import 'dart:io';
import 'dart:math';

Future<void> main(List<String> arguments) async {
  stdout.write('캐릭터의 이름을 입력하세요 : ');
  final name = stdin.readLineSync()!;
  final namePattern = RegExp(r'^[a-zA-Z가-힣]+$'); //정규표현식

  if (!namePattern.hasMatch(name)) {
    print('유효하지 않은 이름입니다. 한글 또는 영문 대소문자만 입력하세요.');
    return;
  }
  print('\n게임을 시작합니다!');

  final game = Game();
  await game.startGame(name);
  game.battle();

}