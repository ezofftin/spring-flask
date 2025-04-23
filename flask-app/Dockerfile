# Python 3.9 이미지를 기반으로 사용
FROM python:3.9

# 한글폰트 설치 (NanumGothic)
RUN apt-get update && apt-get install -y fonts-nanum && fc-cache -fv

# 컨테이너 내부 작업 디렉토리 설정 (/app)
WORKDIR /app

# requirements.txt를 컨테이너에 복사
COPY requirements.txt ./

# requirements.txt에 명시된 패키지들을 설치
RUN pip install --no-cache-dir -r requirements.txt

# 현재 로컬의 모든 파일(Flask 소스, static/, templates/ 포함)을 컨테이너로 복사
COPY . .

# Flask 앱 실행 (spring_app.py가 실행파일)
CMD ["python", "spring_app.py"]