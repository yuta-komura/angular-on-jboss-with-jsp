<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello from JSP + Angular</title>

    <base href="${pageContext.request.contextPath}/" />

    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/angular/browser/styles.css"
    />
  </head>
  <body>
    <h2><%= request.getAttribute("message") %></h2>
    <app-root></app-root>

    <script src="${pageContext.request.contextPath}/angular/browser/polyfills.js"></script>
    <script src="${pageContext.request.contextPath}/angular/browser/main.js"></script>
  </body>
</html>
