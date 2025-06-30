class Game { //게임을 정의하기 위한 클래스
  /*
  - 캐릭터 (`Character`)
  - 몬스터 리스트 (`List<Monster>`)
  - 물리친 몬스터 개수(`int`)
  - 몬스터 리스트의 개수보다 클 수 없습니다.
   */

  void startGame() { //게임을 시작하는 메서드

  }

  void battle() { //전투를 진행하는 메서드

  }

  void getRandomMonster() { //랜덤으로 몬스터를 불러오는 메서드

  }
}

class Character { //캐릭터를 정의하기 위한 클래스
String name;
int health;
int attack;
int defense;

Character(this.name,this.health,this.attack,this.defense);

attackMonster(Monster monster) { //공격 메서드

}

void defend() { //방어 메서드

}

void showStatus() { //상태를 출력하는 메서드

}
}

class Monster { //몬스터를 정의하기 위한 클래스
  String monname;
  int monhealth;
  //공격력최대값;
  //방어력;

  Monster(this.monname, this.monhealth);

attackCharacter(Character character) { //공격 메서드

}

void showStatus() { //상태를 출력하는 메서드
}
}