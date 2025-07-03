<h1 align="center">
<br/>
Dart Console RPG Game Application
</h1>

<div align="center">
  <img width="200" height="300" alt="스크린샷 2025-07-04 00 05 39" src="https://github.com/user-attachments/assets/4d9414ee-10d4-41ef-a165-1c056542a523" />
  <img width="200" height="300" alt="스크린샷 2025-07-03 23 44 54" src="https://github.com/user-attachments/assets/ab33528d-bc92-47fd-8e57-a5ff0610be96" />
  <img width="200" height="300" alt="스크린샷 2025-07-03 23 45 39" src="https://github.com/user-attachments/assets/b903f514-0e4a-42a4-94f9-edbc99abfa73" />
</div>

<h3 align="center">
[Dart 심화] 개인 과제 - RPG Game
</h3>
<p align="center"> 프로젝트 일정 25/06/30~25/07/04
</p>

<br/>
<br/>
<br/>
<h2>프로젝트 개요</h2>

#### 💡 아래의 기능을 활용한 전투 RPG 게임 프로그램
> 랜덤으로 값을 뽑아내는 기능
> 

> 파일 입출력을 처리하는 기능
> 

> 객체 지향을 활용한 전체 구조 생각하기

<br/>
<br/>

## **필수 기능 완료**

### 1. 파일로부터 데이터 읽어오기 기능

**[ 설명 ]**

- 게임(Game 클래스) 시작 시 캐릭터와 몬스터의 스탯을 파일에서 읽어옵니다.

**[ 조건 ]**

- 캐릭터의 스탯은 `characters.txt` 파일에서 읽어옵니다.
- 몬스터들의 스탯은 `monsters.txt` 파일에서 읽어옵니다.
- 파일의 데이터는 **CSV 형식**으로 되어 있습니다.
- 예시
    - 캐릭터 → 체력, 공격력, 방어력
    - 몬스터 →이름, 체력, 공격력 최대값(설정된 최대값에서 `Random()` 을 사용하여 공격력 지정)

---

### 2. 사용자로부터 캐릭터 이름 입력받기 기능

**[ 설명 ]**

- 게임 시작 시 사용자가 캐릭터의 이름을 입력합니다.

**[ 조건 ]**

- 이름은 빈 문자열이 아니어야 합니다.
- 이름에는 **특수문자나 숫자가 포함되지 않아야** 합니다.
- 허용 문자: **한글, 영문 대소문자**

---

### 3. 게임 종료 후 결과를 파일에 저장하는 기능

**[ 설명 ]**

- 게임 종료 후 결과를 파일에 저장합니다.

**[ 조건 ]**

- “결과를 저장하시겠습니까? (y/n)“를 출력합니다.
- 사용자의 입력에 따라 결과를 result.txt 파일에 저장합니다.
- 저장되는 내용은 **캐릭터의 이름, 남은 체력, 게임 결과(승리/패배)** 입니다.
---

### 4. 캐릭터와 몬스터의 공통되는 부분을 추상화하여, 추상 클래스 구현

**[ 설명 ]**

- Character 클래스와 Monster 클래스에서 공통되는 부분을 추상화하여, 이를 추상 클래스로 만들고, 두 클래스가 이 추상 클래스를 상속받도록 코드를 구현합니다.

**[ 조건 ]**

- 추상 클래스에서 공통으로 사용되는 변수 선언
- 상속 받는 클래스에서 함수 재정의 하기. 함수 재정의는 아래와 같은 형식
---



<br/>
<br/>

## TroubleShooting

> ### readAsString() 파일 경로
- 필요성: dart:io 라이브러리의 File 클래스를 사용하여 파일을 읽어오고 싶어서 dart_rpg_game/lib 폴더에 characters.txt와 monsters.txt 파일을 추가한 후 아래와 같은 코드를 작성하고 dart run 했는데 오류가 발생
- 해결책: 경로를 바꿔서 lib/characters.txt 를 직접 가리키는 방법
- 개선점: txt파일의 정보를 올바르게 출력

> ### Too few positional arguments 오류
- 문제: Monster.attackTarget() {
  character.defend(); //인자 누락 오류 발생
  }
- 해결책: defend() 메서드는 공격력(int)을 인자로 받도록 정의
- 개선점: Monster.attackTarget() {
  character.defend(monster.attack); //인자 전달 추가
  }

> ### 터미널 입력 자동 줄바꿈
- 문제: //print() -> 자동 줄바꿈
       print('캐릭터의 이름을 입력하세요 : ');
       String name = stdin.readLineSync();
- 해결책: //stdout.write()를 사용해 같은 줄에 출력되도록 변경
        stdout.write('캐릭터의 이름을 입력하세요: ');
        String name = stdin.readLineSync();
- 개선점: 올바르게 출력 -> 캐릭터의 이름을 입력하세요 : gkswh

> ### Future<void> ____() async {...}
- 문제: await game.startGame(name);
- 해결책: startGame()이 아무것도 반환하지 않는데(void), await는 Future가 반환되어야 사용 가능
- 개선점:<br/>

>        //기존 코드
>        void startGame(String name) {
>           ...
>        }
>        //변경한 코드
>        Future<void> startGame(String name) async {
>           ...
>           //내부에서 await 사용하려면 반드시 async 선언
>        }


> ### 파일 디렉토리 나누기
- 문제: bin/dart_rpg_game.dart에 코딩을 하다가 클래스마다 코드가 길어져서 읽기가 힘들어짐
- 해결책: lib 폴더에 클래스별로 dart 파일 생성 후 직접 import <br/>
        import 'dart_rpg_game.dart'; <br/>
        import 'game.dart'; <br/>
        import 'character.dart'; <br/>
        import 'monster.dart';
- 개선점: 클래스별로 파일이 나눠져있어 가독성이 향상
<br/>
<br/>


