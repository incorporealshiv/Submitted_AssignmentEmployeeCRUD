<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>An error occurred</h1>
    <p>
        <c:if test="${not empty error}">
            ${error}
        </c:if>
    </p>
    <a href="<c:url value='/employees/all-employees'/>">Go back to employee list</a>
</body>
</html>
