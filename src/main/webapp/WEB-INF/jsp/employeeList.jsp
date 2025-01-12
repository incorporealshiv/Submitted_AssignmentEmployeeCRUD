<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #4CAF50;
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            padding: 8px 16px;
            margin: 0 5px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            font-weight: bold;
        }

        .pagination a:hover {
            background-color: #45a049;
        }

        .pagination span {
            padding: 8px 16px;
            margin: 0 5px;
            font-weight: bold;
            display: inline-block;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .actions a {
            padding: 6px 12px;
            background-color: #007BFF;
            color: white;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
            
         }

        .actions a:hover {
            background-color: #0056b3;
        }

        .add-employee-link {
            display: block;
            text-align: center;
            margin: 20px 0;
            font-size: 18px;
            
        }
    </style>
    
    <script type="text/javascript">
    
    function confirmDelete() {
        return confirm('Are you sure you want to delete this employee?');
    }
    </script>
</head>
<body>

    <h2>Employee List</h2>
    
    

    <!-- Employee Table -->
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Department</th>
                <th>Designation</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Joining Date</th>
                <th>Salary</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="employee" items="${employees}">
                <tr>
                    <td>${employee.name}</td>
                    <td>${employee.department}</td>
                    <td>${employee.designation}</td>
                    <td>${employee.email}</td>
                    <td>${employee.phone}</td>
                    <td>${employee.joiningDate}</td>
                    <td>${employee.salary}</td>
                    <td class="actions">
                        <a href="/employees/edit/${employee.id}/${currentPage + 1}">Edit</a> 
                        <%-- <a href="/employees/delete/${employee.id}">Delete</a> --%>
                        <a href="/employees/delete/${employee.id}" onclick="return confirmDelete()">Delete</a>
                        
                    </td> 
                    
                  <%--    <td class="actions">
                        <!-- Edit Button -->
                        <form action="/employees/edit/${employee.id}" method="get">
                            <button type="submit">Edit</button>
                        </form>

                        <!-- Delete Button -->
                        <form action="/employees/delete/${employee.id}" method="post">
                            <button type="submit" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</button>
                        </form>
                    </td> --%>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="pagination">
        <span>Page ${currentPage + 1} of ${totalPages}</span>
        
        <c:if test="${currentPage > 0}">
            <a href="/employees/all-employees?page=${currentPage - 1}&size=${pageSize}">Previous</a>
        </c:if>
        
        <c:if test="${currentPage < totalPages - 1}">
            <a href="/employees/all-employees?page=${currentPage + 1}&size=${pageSize}">Next</a>
        </c:if>
    </div>
<!-- Add New Employee Link -->
    <div class="add-employee-link">
        <a href="/employees/new">Add New Employee</a>
    </div>
</body>
</html>
