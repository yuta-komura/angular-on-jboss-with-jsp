# angular-on-jboss-with-jsp

Angular（スタンドアロンコンポーネント構成）と Java Servlet（JSP）を組み合わせ、WildFly（JBoss）上で動作するハイブリッド Web アプリケーションのサンプルです。

---

## 📁 プロジェクト構成

```
angular-on-jboss/
├── angular-app/          # Angular アプリ（standalone 構成）
├── backend/              # Java Servlet アプリ（Ant ビルド）
│   ├── src/
│   ├── build.xml         # Ant スクリプト
│   └── dist/frontend.war # ビルド後の WAR ファイル
```

---

## 🔧 システム構成と動作の流れ

このプロジェクトは、**JSP をエントリーポイントとして Angular アプリを読み込む構成**です。

1. ブラウザが `/frontend/hello` にアクセス
2. `HelloServlet.java` が `/WEB-INF/jsp/index.jsp` にフォワード
3. `index.jsp` で `<app-root>` タグを使って Angular を初期化
4. Angular が `main.js` / `polyfills.js` を読み込み、画面が描画される

---

## 🚀 クイックスタート

### 1. Angular + Java のビルド

```bash
cd backend
ant build
```

- Angular ビルドも Ant 内で実行されます（`ng build --configuration production`）
- `dist/frontend.war` が生成されます

### 2. WildFly（JBoss）へデプロイ

以下のフォルダに WAR ファイルを配置してください：

```
C:\tools\jboss\wildfly-36.0.0.Beta1\standalone\deployments\frontend.war
```

### 3. WildFly の起動

```bash
C:\tools\jboss\wildfly-36.0.0.Beta1\bin\standalone.bat
```

---

## 🌐 アクセス確認

### ✅ 本番構成（WildFly）

```
http://localhost:8080/frontend/hello
```

- JSP に `<app-root>` を埋め込んで Angular を起動
- Servlet + JSP + Angular の連携確認が可能

### ✅ 開発モード（ng serve）

Angular 単体での動作確認も可能です：

```bash
cd angular-app
ng serve
```

ブラウザでアクセス：

```
http://localhost:4200/frontend/hello
```

- JSP を使わず Angular 単体で確認できます
- ホットリロードが有効なので開発に便利です

---

## 🛠 使用技術

- **Angular 17**
  - スタンドアロンコンポーネント
  - Zone.js を使用（`main.ts` に `import 'zone.js'`）
- **Java 11**
- **Jakarta Servlet 6.0 / JSP**
- **Ant** によるビルド
- **WildFly 36.0.0.Beta1**（旧 JBoss）

---

## 📝 `index.jsp` の例

Angular のビルド成果物は `angular/` 以下に配置され、以下のように JSP から読み込まれます：

```jsp
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <base href="/frontend/" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/angular/styles.css" />
  </head>
  <body>
    <app-root></app-root>

    <script src="${pageContext.request.contextPath}/angular/polyfills.js"></script>
    <script src="${pageContext.request.contextPath}/angular/main.js"></script>
  </body>
</html>
```

---

## 🧪 開発メモ

- `AppComponent` に `standalone: true` を忘れずに設定
- Angular が表示されない場合は、JSP から `main.js` などのスクリプトパスが正しいか確認
- Ant 経由で `ng build` するには `ng.cmd` のパスを使い、エラー時はログファイル（例: `angular-build.log`）で詳細確認可能

---
