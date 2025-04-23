# Tomcat 9 이미지 사용
# tomcat 이미지 안에는 jdk11 또는 17이 포함되어 있음
# 원하는 JDK 17버전 사용시에는 tomcat:9.0-jdk17
FROM tomcat:9.0

# 기존 ROOT 앱 제거, ROOT 디렉토리 안에는 Tomcat의 기본 welcome 페이지가 존재
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# 빌드된 war 파일을 Tomcat에 복사
COPY target/flask_chart.war /usr/local/tomcat/webapps/ROOT.war

# ROOT.war 파일이 있으면
# localhost:8080/컨텍스명  --> localhost:8080 (컨텍스트 경로 없이 실행됨)

