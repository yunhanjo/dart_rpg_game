import 'dart:math';
import 'fight.dart';
import 'character.dart';


class Monster extends Fight { //몬스터를 정의하기 위한 클래스
  int maxAttack;

  Monster(String name, int health, int maxAttack, int characterDefense)
    : maxAttack = maxAttack,
      super(name, health, _makeAttack(maxAttack, characterDefense),);

  static int _makeAttack(int maxAttack, int defense) {
  final rand = Random();

  // defense보다 큰 랜덤 공격력 만들기
  int attack = rand.nextInt(maxAttack + 1);

  // 공격력이 너무 낮으면 강제로 defense보다 크게 만들기
  if (attack <= defense) {
    attack = defense + 1;
    if (attack > maxAttack) {
      attack = maxAttack; // maxAttack은 넘지 않게
    }
  }
  return attack;
}

  @override
  void attackTarget(Fight target, {bool isDefending = false}) { //재정의한 공격 메서드
    print('\n${name}의 턴');
    print('$name이 ${target.name}에게 ${attack}의 데미지를 입혔습니다.');
    target.health -= attack;
    target.showStatus();
    showStatus();
  }

  attackCharacter(Character character) { //공격 메서드
    print('$name이 ${character.name}에게 $attack의 데미지를 입혔습니다.');
    character.health -= attack;
  }

  @override
  void showStatus() { //상태를 출력하는 메서드
    print('[$name] - 체력: $health, 공격력: $attack');
  }
}