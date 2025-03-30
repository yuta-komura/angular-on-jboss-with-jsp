# angular-on-jboss-with-jsp

Angular（単独コンポーネント構成）と Java Servlet を組み合わせ、WildFly（JBoss）上で動作する Web アプリケーションのサンプルです。

## 📁 プロジェクト構成

```
angular-on-jboss/
├── angular-app/          # Angular アプリ（スタンドアロンコンポーネント構成）
├── backend/              # Java Servlet アプリ（Ant によるビルド）
│   ├── src/
│   ├── build.xml         # Ant ビルドスクリプト
│   └── dist/frontend.war # 生成される WAR ファイル
```

---

## 📦 構成の特徴

本プロジェクトでは、**JSP をエントリーポイントとして使用し、Angular アプリを読み込む**構成を採用しています。

読み込みの流れ：

1. クライアントが `/frontend/hello` にアクセス
2. `HelloServlet` が `/WEB-INF/jsp/index.jsp` にフォワード
3. `index.jsp` 内で `<app-root>` を含む Angular アプリを初期化

このようにして、**JSP と Angular が共存するハイブリッド構成**を実現しています。

---

## 🚀 クイックスタート

### 🛠 1. Angular アプリをビルド + Java Servlet + JSP の WAR をビルド

```bash
cd ../backend
ant build
```

> `dist/frontend.war` が作成されます。

---

### 🔧 2. WildFly（JBoss）にデプロイ

`frontend.war` を WildFly の `standalone/deployments` ディレクトリに配置してください：

```
C:\tools\jboss\wildfly-36.0.0.Beta1\standalone\deployments\frontend.war
```

### 🐘 3. 起動

```
C:\tools\jboss\wildfly-36.0.0.Beta1\bin\standalone.bat
```

---

## 🌐 アクセス確認

### ✅ サーブレット確認

以下の URL にアクセスして、JSP と Servlet が正しく動作するか確認します：

```
http://localhost:8080/frontend/hello
```

この URL では：

- `HelloServlet.java` が `/WEB-INF/jsp/index.jsp` をフォワードします
- JSP 内部で Angular アプリのタグ `<app-root>` が埋め込まれます
- `main.js` / `polyfills.js` が読み込まれ、Angular が動作開始します

---

## 📜 使用技術

- **Angular 17**
  - スタンドアロンコンポーネント構成
  - Zone.js を使用（`main.ts` に `import 'zone.js'`）
- **Java 11**
- **Servlet 6.0 / JSP**
- **Ant** による WAR ビルド
- **WildFly 36.0.0.Beta1**（JBoss）

---

## 💡 補足: `index.jsp` の例

```jsp
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello from JSP + Angular</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/angular/browser/styles.css" />
  </head>
  <body>
    <h2><%= request.getAttribute("message") %></h2>
    <app-root></app-root>

    <script src="${pageContext.request.contextPath}/angular/browser/polyfills.js"></script>
    <script src="${pageContext.request.contextPath}/angular/browser/main.js"></script>
  </body>
</html>
```

---

## 🧪 開発メモ

- Angular 側の `AppComponent` は `standalone: true` 必須
- `polyfills.ts` は `zone.js` を明示的に `import` する必要あり
- JBoss にデプロイしても Angular が表示されない場合、`main.js` や `polyfills.js` の読み込みパスを JSP で確認する

---
