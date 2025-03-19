<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Session Management using Cookies</title>
</head>
<body>
    <h2>Session Management using Cookies</h2>
    <%
        String username = request.getParameter("usernm");
        Cookie[] cookies = request.getCookies();
        int visitCount = 0;
        boolean userExists = false;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("visitCount".equals(cookie.getName())) {
                    visitCount = Integer.parseInt(cookie.getValue());
                }
                if ("username".equals(cookie.getName())) {
                    userExists = true;
                }
            }
        }

        visitCount++;
        Cookie visitCookie = new Cookie("visitCount", String.valueOf(visitCount));
        visitCookie.setMaxAge(60 * 60 * 24);
        response.addCookie(visitCookie);

        if (!userExists && username != null && !username.isEmpty()) {
            Cookie userCookie = new Cookie("username", username);
            userCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(userCookie);
        }
    %>
    <p>Hello <%= (username != null && !username.isEmpty()) ? username : "Guest" %>, You have hit the page <%= visitCount %> time(s)</p>
    <a href="CookiesDemo.jsp?usernm=<%= username != null ? username : "" %>">Hit Again</a>
</body>
</html>