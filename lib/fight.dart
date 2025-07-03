abstract class Fight {
  String name;
  int health;
  int attack;

  Fight(this.name, this.health, this.attack);

  void showStatus();
  void attackTarget(Fight target);
}