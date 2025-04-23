from flask import Flask, render_template, url_for, jsonify
import pandas as pd #pip install pandas
import matplotlib
# matplotlib는 기본적으로 GUI를 사용
# 웹 환경에서는 GUI 사용하지 않도록 설정
matplotlib.use('Agg') 
import matplotlib.pyplot as plt # pip install matplotlib
import os
import seaborn as sns # pip install seaborn

# FLASK_SERVER_URL = "http://localhost:5000"
FLASK_SERVER_URL = "http://3.38.85.139:5000"

# 한글 폰트 설정 (리눅스에서는 나눔고딕)
plt.rc("font", family="NanumGothic")
# 마이너스(-) 기호 깨짐 방지
plt.rcParams["axes.unicode_minus"] = False


app = Flask(__name__)
# app.static_folder --> c:\study_python\flask_chart\static\
csv_path = os.path.join(app.static_folder, "h_clean.csv")
# os.path.join("a", "b", "h.csv") window: a\b\h.csv, linux: a/b/h.csv
csv_path2 = os.path.join(app.static_folder, "ta_20231231.csv")
print(csv_path)

# 데이터 로드
df=pd.read_csv(csv_path)
df2=pd.read_csv(csv_path2, encoding="euc-kr")

@app.route('/')
def home():    
    return jsonify({"msg":"chart API"})

@app.route("/api/static-image")
def plot_png():    
    region = "서울"
    df_seoul = df[df["지역명"] == region]

    # 연도별 평균 분양가격 계산
    yearly_prices = df_seoul.groupby("연도")["분양가격"].mean()

    # plt.plot() 사용
    plt.figure(figsize=(10, 5))
    plt.plot(yearly_prices.index, yearly_prices.values, marker="o", linestyle="-", color="b")

    plt.xlabel("연도")
    plt.ylabel("평균 분양가격 (천 원)")
    plt.title(f"{region} 연도별 평균 분양가격 변화")
    plt.grid(True)

    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
        os.makedirs("static")

    # 차트 이미지 저장 경로 생성
    file_path = os.path.join(app.static_folder, "plot.png")

    plt.savefig(file_path, format="png")  # 파일 저장  
    plt.close()  # 메모리 해제, matplotlib는 메모리 동작하기 때문에 사용후 메모리에서 제거 

    #_external의 기본값은 False : "/static/plot.png"(상대 URL 반환)
    # 외부에서 요청할 수 있도록
    #_external=True : http://127.0.0.1:5000/static/plot.png(절대 URL 반환)
    # return jsonify({"image_url":url_for('static', filename='plot.png', _external=True)})
    return jsonify({"image_url": f"{FLASK_SERVER_URL}/static/plot.png"})

# 지역별 평균 분양가격 차트
@app.route("/api/region-average")
def region_average():
    # 지역별 평균 분양가격 계산
    region_avg_price = df.groupby("지역명")["분양가격"].mean().sort_values(ascending=False)

    # 그래프 생성
    plt.figure(figsize=(12, 6))
    plt.bar(region_avg_price.index, region_avg_price.values, color="g")
    plt.title("지역별 평균 분양가격")
    plt.xlabel("지역명")
    plt.ylabel("평균 분양가격 (만원)")
    plt.xticks(rotation=45)

    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
        os.makedirs("static")

    file_path = os.path.join(app.static_folder, "region_avg.png")
    plt.savefig(file_path, format="png", dpi=100)
    plt.close()  # 메모리 해제

    # 웹페이지에 차트 표시    
    # return jsonify({"image_url":url_for('static', filename='region_avg.png', _external=True)})
    return jsonify({"image_url": f"{FLASK_SERVER_URL}/static/region_avg.png"})
# 시군구별 비율 (파이 차트)
@app.route("/api/ta-pie")
def ta_pie():
    top_sigu = df2.groupby("시군구")["사고건수"].sum().sort_values(ascending=False).head(10)

    plt.figure(figsize=(8, 8))
                                                                                # Seaborn의 palette 속성을 사용
    plt.pie(top_sigu, labels=top_sigu.index, autopct="%1.1f%%", startangle=140, colors=sns.color_palette("pastel"))
    plt.title("교통사고 발생 수에 따른 시군구별 비율 (상위 10개)")
    

    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
        os.makedirs("static")

    file_path = os.path.join(app.static_folder, "pie.png")
    plt.savefig(file_path, format="png")
    plt.close()  # 메모리 해제

    # return jsonify({"image_url":url_for('static', filename='pie.png', _external=True)})
    return jsonify({"image_url": f"{FLASK_SERVER_URL}/static/pie.png"})

if __name__ == '__main__':
    # 외부에서 Flask 서버에 접근하도록 host="0.0.0.0" 설정해야 함
    app.run(host="0.0.0.0", port=5000, debug=True)