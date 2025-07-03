import 'fight.dart';
import 'monster.dart';

class Character extends Fight { //캐릭터를 정의하기 위한 클래스
  int defense;

  Character(String name, int health, int attack, this.defense)
    : super(name, health, attack);

  @override
  void attackTarget(Fight target) { //재정의한 공격 메서드
    print('$name이(가) ${target.name}에게 $attack의 데미지를 입혔습니다.');
    int damage = attack - (target is Monster ? 0 : (target as Character).defense);
    if (damage < 0) damage = 0;
    target.health -= damage;
  }

  attackMonster(Monster monster) { //공격 메서드
    print('$name이(가) ${monster.name}에게 $attack의 데미지를 입혔습니다.');
    monster.health -= attack;
  }

  void defend(int damage) { //방어 메서드
    int gethealth = damage - defense; //ex) 얻은체력17 = 몬스터공격22 - 캐릭터방어5
    health += gethealth;
      print('$name이(가) 방어 태세를 취하여 $gethealth만큼 체력을 얻었습니다.');
  }

  @override
  void showStatus() { //상태를 출력하는 메서드
    print('[$name] - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}