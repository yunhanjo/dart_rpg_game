import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';

class Game { //게임을 정의하기 위한 클래스
  late Character character;
  List<Monster> monsters = [];

  Future<void> startGame(String name) async {
    final characterStat = await File('lib/characters.txt').readAsString();
    final split = characterStat.trim().split(',');
    character = Character(
      name,
      int.parse(split[0]),
      int.parse(split[1]),
      int.parse(split[2]),
    );
    character.showStatus();

    final monsterStat = await File('lib/monsters.txt').readAsString();
    final lines = monsterStat.trim().split('\n');
    for (var line in lines) {
      final parts = line.trim().split(',');
      monsters.add(Monster(parts[0], int.parse(parts[1]), int.parse(parts[2]), character.defense));
    }
    print('\n새로운 몬스터가 나타났습니다!');
  }

  void battle() { //전투를 진행하는 메서드
    while (monsters.isNotEmpty && character.health > 0) {
      Monster monster = getRandomMonster();
      monster.showStatus();

      while (monster.health > 0 && character.health > 0) {
        print('\n${character.name}의 턴');
        stdout.write('행동을 선택하세요 (1.공격   2.방어) : ');
        String? input = stdin.readLineSync();

        if (input == '1') {
          character.attackTarget(monster);
          if (monster.health <= 0) {
            print('${monster.name}을(를) 물리쳤습니다!');
            monsters.remove(monster); //몬스터 삭제
            stdout.write("다음 몬스터와 싸우시겠습니까? (y/n)");
            String? input = stdin.readLineSync();
            if (input?.toLowerCase() == 'y') {
              print('\n새로운 몬스터가 나타났습니다!');
              break;
            } else if (input?.toLowerCase() == 'n') {
              saveResult();
              return;
            }
          } else { 
            monster.attackTarget(character);
          }
        } else if (input == '2') {
          character.defend(monster.attack);
          monster.attackTarget(character, isDefending: true);
        } else {
          print('잘못된 입력입니다.');
        }
        if (character.health <= 0) {
          print('${character.name}이(가) 졌습니다.');
          break;
        }
      }
    }

    if (character.health > 0) {
      print('\n축하합니다! 모든 몬스터를 물리쳤습니다.');
    } else {
      print('\nGAME OVER');
    }
    saveResult();
  }

  Monster getRandomMonster() { //랜덤으로 몬스터를 불러오는 메서드
    final rand = Random();
    return monsters[rand.nextInt(monsters.length)];
  }

  void saveResult() { //결과를 저장하는 메서드
    stdout.write("결과를 저장하시겠습니까? (y/n)");
    String? input = stdin.readLineSync();
    if (input?.toLowerCase() == 'y') {
      final result = character.health > 0 ? '승리' : '패배';
      File('lib/result.txt').writeAsStringSync(
        '이름: ${character.name}, 남은 체력: ${character.health}, 결과: $result',
      );
      print('결과가 result.txt에 저장되었습니다.');
    } else {
      print("결과를 저장하지 않았습니다.");
    }
  }
}
