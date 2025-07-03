import 'package:dart_rpg_game/dart_rpg_game.dart' as dart_rpg_game;
import 'dart:io';
import 'dart:math';

String name = "";
String mon_name = "";

class Game { 
  //게임을 정의하기 위한 클래스
  late Character character;
  List<Monster> monsters = [];

  void startGame() {
    //게임을 시작하는 메서드
    File('lib/characters.txt').readAsString().then((String characterstat) {
      var cha_splitStr = characterstat.trim().split(','); //캐릭터 스탯 분리

      int cha_helath = int.parse(cha_splitStr[0]); //캐릭터체력
      int cha_attack = int.parse(cha_splitStr[1]); //캐릭터공격력
      int cha_defense = int.parse(cha_splitStr[2]); //캐릭터방어력

      character = Character(name, cha_helath, cha_attack, cha_defense);
      print(
        '${character.name} - 체력 : ${character.health}, 공격력 : ${character.attack}, 방어력 : ${character.defense}',
      );
      character.showStatus();
    });

    File('lib/monsters.txt').readAsString().then((String monsterstat) {
      List<String> mon_splitStr = monsterstat.trim().split('\n'); //몬스터 스탯 분리

      for (var line in mon_splitStr) {
        var m_split = line.trim().split(','); // 한 줄의 몬스터 스탯 분리

        mon_name = m_split[0];
        int mon_health = int.parse(m_split[1]);
        int mon_attackMax = int.parse(m_split[2]);

        monsters.add(Monster(mon_name, mon_health, mon_attackMax));
      }

      battle();

      //print('${monster.monname} 생성됨. 랜덤 공격력: ${monster.monattack}');
      //print('$name - 체력 : $mon_helath, 공격력 : $mon_attack, 방어력 : $mon_defense');
    });
  }

  void battle() {
    //전투를 진행하는 메서드
    while (monsters.isNotEmpty && character.health > 0) {
      Monster monster = getRandomMonster();
      print('\n몬스터 [${monster.name}]와 전투 시작!');
      monster.showStatus();

      while (monster.health > 0 && character.health > 0) {
        print('\n행동을 선택하세요: 1. 공격  2. 방어');
        String? input = stdin.readLineSync();

        if (input == '1') {
          character.attackTarget(monster);
          if (monster.health <= 0) {
            print('${monster.name}을(를) 물리쳤습니다! - 몬스터 제거');
            monsters.remove(monster);
            break;
          }
        } else if (input == '2') {
          print('${character.name}이(가) 방어합니다! (방어력 적용)');
          monster.attackTarget(character, isDefending: true);
        }

        monster.attackTarget(character);
        character.defend(monster.attack);
        if (character.health <= 0) {
          print('${character.name}이(가) 쓰러졌습니다...');
          break;
        }
      }
    }

    if (character.health > 0) {
      print('\n모든 몬스터를 처치했습니다! 승리!');
    } else {
      print('\n게임 오버. 패배하였습니다.');
    }

    saveResult();
  }

  Monster getRandomMonster() {
    //랜덤으로 몬스터를 불러오는 메서드
    final rand = Random();
    return monsters[rand.nextInt(monsters.length)];
  }

  void saveResult() {
    //결과를 저장하는 메서드
    print("결과를 저장하시겠습니까? (y/n)");
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

abstract class Fight {
  String name;
  int health;
  int attack;

  Fight(this.name, this.health, this.attack);

  void showStatus();
  void attackTarget(Fight target);
}

class Character extends Fight {
  //캐릭터를 정의하기 위한 클래스
  int defense;

  Character(String name, int health, int attack, this.defense)
    : super(name, health, attack);

  @override
  void attackTarget(Fight target) {
    print('$name이(가) ${target.name}을(를) 공격합니다! 공격력: $attack');
    int damage =
        attack - (target is Monster ? 0 : (target as Character).defense);
    if (damage < 0) damage = 0;
    target.health -= damage;
  }

  attackMonster(Monster monster) {
    //공격 메서드
    print('$name 이(가) ${monster.name}에게 $attack의 피해를 입힙니다!');
    monster.health -= attack;
  }

  void defend(int incomingDamage) {
    //방어 메서드
    int recover = defense - incomingDamage;
  if (recover > 0) {
    health += recover;
    print('$name이(가) 방어 성공! 체력 $recover 회복 (현재 체력: $health)');
  } else {
    print('$name이(가) 방어 실패! (회복 없음)');
  }
  }

  @override
  void showStatus() {
    //상태를 출력하는 메서드
    print('[$name] 체력: $health / 공격력: $attack / 방어력: $defense');
  }
}

class Monster extends Fight {
  //몬스터를 정의하기 위한 클래스
  int maxAttack;

  Monster(monname, int health, this.maxAttack)
    : super(monname, health, Random().nextInt(maxAttack + 1));

  attackCharacter(Character character) {
    //공격 메서드
    print('$mon_name 이(가) ${character.name}에게 $attack의 피해를 입힙니다!');
    character.health -= attack;
  }

  @override
  void attackTarget(Fight target, {bool isDefending = false}) {
    print('$mon_name 이(가) ${target.name}에게 $attack의 피해를 입힙니다!');
  
  if (target is Character && isDefending) {
    target.defend(attack);
  } else {
    target.health -= attack;
  }
  }

  @override
  void showStatus() {
    print('[$mon_name] 체력: $health / 공격력: $attack (최대 $maxAttack)');
  }
}

void main(List<String> arguments) {
  print('캐릭터의 이름을 입력하세요 : ');
  name = stdin.readLineSync()!;
  final namePattern = RegExp(r'^[a-zA-Z가-힣]+$'); //정규표현식
  if (namePattern.hasMatch(name)) {
    print('올바른 이름입니다: $name');
    print('게임을 시작합니다!');

    Game game = Game();
    game.startGame();
  } else {
    print('유효하지 않은 이름입니다. 한글 또는 영문 대소문자만 입력하세요.');
  }
}
