# SPARK <br><br>


<font size="2em" color="red"> ※ 반드시 Windows 10 최신 버전으로 업데이트 할 것 </font>
* <a href="#a1">1.WSL 설치</a>
* <a href="#a2">2.Ubuntu 18.04 LTS 설치</a>
* <a href="#a3">3.JAVA 8 설치</a>
* <a href="#a4">4.Miniconda 설치</a>
* <a href="#a5">5.conda 가상환경 만들기</a>
* <a href="#a6">6.Spark 설치</a>
* <a href="#a7">7.환경변수 설정</a>
* <a href="#a8">8.Spark 실행</a>

<a name="a1"></a>
## 1.WSL 설치
* 제어판 - 프로그램 및 기능 - Windows 기능 켜기/끄기 - Linux용 Windows 하위 시스템 체크 - 재부팅
* Microsoft Store에서 Windows Terminal 설치
* https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi WSL2 설치
* Windows Terminal 실행
* Linux용 Windows 하위 시스템 설치 <br>
  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart 입력
* '가상 머신 플랫폼' 옵션 구성 요소 사용 <br>
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 입력
* WSL 2를 기본 버전으로 설정 <br>
  wsl --set-default-version 2 입력
* 버전 확인 : wsl -l -v

<a name="a2"></a>
## 2.Ubuntu 18.04 LTS 설치
* Microsoft Store에서 Ubuntu 18.04 LTS 설치
* 실행 후 사용자 아이디 입력 및 패스워드 입력

<a name="a3"></a>
## 3.JAVA 8 설치
* sudo apt-get update
* sudo apt-get install openjdk-8-jdk
* java -version
* 자바 환경변수 설정 <br>
  which java로 경로 확인 <br>
  vim ~/.bashrc 실행 <br>
  shift + g (맨 밑으로 이동) <br>
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ <br>
  source ~/.bashrc <br>
  echo $JAVA_HOME <br>
  $JAVA_HOME/bin/java -version

<a name="a4"></a>
## 4.Miniconda 설치
* Linux 환경으로 설치 (python 3.8) <br>
  mkdir download (디렉토리 생성) - cd download - download 디렉토리에 파일 설치 <br>
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
* sh Miniconda3-latest-Linux-x86_64.sh <br>
  디렉토리 설정 : /home/geon/apps/miniconda3

<a name="a5"></a>
## 5.Conda 가상환경 만들기
* Ubuntu 나갔다가 다시 재접속
* conda create --name=py36 python=3.6 <br>
  name=py36에서 py36은 자유롭게 설정하면 됨
* conda activate py36  <br>
  (base) -> (py36)으로 변경

<a name="a6"></a>
## 6.Spark 설치
* 2.4.7 version - download spark click - mirror 링크 복사
* download 디렉토리에서 설지 <br>
  wget http://mirror.apache-kr.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz <br>
  tar xvfz spark-2.4.7-bin-hadoop2.7.tgz
  ln -s ~/download/spark-2.4.7-bin-hadoop2.7 spark (링크 연결) <br>
 
<a name="a7"></a>
## 7.환경변수 설정
* 아무 경로에서나 pyspark 실행하기 위해 경로 설정 <br>
  vim ~/.bashrc <br>
  export SPARK_HOME=/home/geon/apps/spark <br>
  export PATH=$PATH:$SPARK_HOME/bin <br>
  source ~/.bashrc
<img src="https://user-images.githubusercontent.com/48666867/94445272-35b19800-01e2-11eb-859b-e90f5a0836c7.PNG" width="90%"></img>



<a name="a8"></a>
## 8.Spark 실행
* source ~/.bashrc를 실행하면 (py36) 에서 다시 (base)로 변경 됨
* 다시 conda activate py36 실행 후 (py36)으로 변경
* pyspark 입력하면 spark 실행 완료
* 나가려면 exit() 
<img src="https://user-images.githubusercontent.com/48666867/94445266-34806b00-01e2-11eb-8971-cb4ab0937fe4.PNG" width="90%"></img>
