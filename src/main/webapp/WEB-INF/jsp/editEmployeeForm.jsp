<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
        }

        h2,h1{
            text-align: center;
            color: #333;
            padding-top: 20px;
        }

        .form-container {
            width: 50%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 20px;
        }

        .form-container label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="number"],
        .form-container input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-container input[type="text"]:focus,
        .form-container input[type="email"]:focus,
        .form-container input[type="number"]:focus,
        .form-container input[type="date"]:focus {
            border-color: #4caf50;
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        .form-container .form-row {
            margin-bottom: 20px;
        }

        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
            font-weight: bold;
        }

        .back-button:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
    
<script type="text/javascript">
    // Function to validate email
    function validateEmail() {
        var email = document.getElementById("email").value;
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        document.getElementById("emailError").innerText = "";

        if (!emailPattern.test(email)) {
            document.getElementById("emailError").innerText = "Please enter a valid email address.";
            document.getElementById("emailError").style.color = "red";
            return false;  // Return false if validation fails
        }
        return true;  // Return true if validation passes
    }

    // Function to validate phone number
    function validatePhone() {
        var phone = document.getElementById("phone").value;
        var phonePattern = /^\d{10}$/;
        document.getElementById("phoneError").innerText = "";

        if (!phonePattern.test(phone)) {
            document.getElementById("phoneError").innerText = "Please enter a valid 10-digit phone number.";
            document.getElementById("phoneError").style.color = "red";
            return false;  // Return false if validation fails
        }
        return true;  // Return true if validation passes
    }
    
    
    
    
    
    
    function validateJoiningDate() {
        const joiningDateInput = document.getElementById("joiningDate");
        const errorDiv = document.getElementById("joiningDateError");
        /* const dateValue = joiningDateInput.value.trim(); */
        const dateValue = joiningDateInput.value?.trim(); // Check for null or undefined

        const datePattern = /^(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-\d{4}$/; // dd-mm-yyyy

        if (dateValue === "") {
            /* errorDiv.textContent = "Joining Date is required."; */
            document.getElementById("joiningDateError").innerText = "Joining Date is required.";
            document.getElementById("joiningDateError").style.color = "red";
            return false; 

        } else if (!datePattern.test(dateValue)) {
/*             errorDiv.textContent = "Please enter a valid date in 'dd-mm-yyyy' format.";
 */        
 
        	document.getElementById("joiningDateError").innerText = "Please enter a valid date in 'dd-mm-yyyy' format.";
            document.getElementById("joiningDateError").style.color = "red";
            return false; 
        } else {
        	document.getElementById("joiningDateError").innerText = ""; // Clear error if valid
        	 return true;
        }
       
    }

    // Function to validate the form before submission
    function validateForm(event) {
        var isEmailValid = validateEmail();
        var isPhoneValid = validatePhone();
        
        var isJoiningDateValid = validateJoiningDate();
/*         alert("isJoiningDateValid "+isJoiningDateValid);
 */

        if (!isEmailValid || !isPhoneValid ||!isJoiningDateValid) {
            event.preventDefault();  // Prevent form submission if any validation fails
            return false;
        }
        return true;  // Allow form submission if all validations pass
    }
    
    
    
    
    // Function to allow only numeric input for phone field
    function allowNumericInput(event) {
/*         var input = document.getElementById("phone");
 */
 
 var input = event.target;

 
 		var value = input.value;
        var newValue = value.replace(/\D/g, '');  // Remove any non-digit characters
        input.value = newValue;
    }
    
    
    function confirmUpdate() {
    	
    	  var isFormValid = validateForm(event);

    	    if (!isFormValid) {
    	        alert("Please fix the errors before submitting the form.");
    	        return false;  // Stop the update if form is not valid
    	    }
        return confirm("Are you sure you want to update the information?");
    }
    
    
    
</script>


    
</head>
<body>
    <h1>Employee Form</h1>
    
  <h2>Update Employee Information Form</h2>
    <div class="form-container">
        <form:form modelAttribute="employee" action="/employees/save" method="post" onsubmit="return confirmUpdate()">
            <div class="form-row">
                <form:input path="id" id="id" required="true" style="display:none;"/>
            </div>
            
            
            
             <div class="form-row">
                <label for="name">Name:</label>
                <form:input path="name" id="name" required="true" />
            </div>
            
            
            
            
             <div class="form-row">
    <label for="phone">Email:</label>
    <form:input path="email" id="email" required="true" onblur="validateEmail()" 
         />
    <div id="emailError"></div>  <!-- Error message will appear here -->
</div>

          
    
          <%--   <div class="form-row">
                <label for="email">Email:</label>
                <form:input path="email" id="email" required="true" />
            </div>

            <div class="form-row">
                <label for="phone">Phone:</label>
                <form:input path="phone" id="phone" required="true" maxlength="10" />
            </div> --%>
            
            
        

   <!--  <div class="form-row">
        <label for="phone">Phone:</label>
        <input type="text" id="phone" required="true" maxlength="10" onblur="validatePhone()"
         oninput="allowNumericInput(event)"/>
        <div id="phoneError"></div>  Error message will appear here
    </div> -->
    
    
    <div class="form-row">
    <label for="phone">Phone:</label>
    <form:input path="phone" id="phone" required="true" maxlength="10" onblur="validatePhone()" 
        oninput="allowNumericInput(event)" />
    <div id="phoneError"></div>  <!-- Error message will appear here -->
</div>
    


            <div class="form-row">
                <label for="department">Department:</label>
                <form:input path="department" id="department" required="true" />
            </div>

            <div class="form-row">
                <label for="designation">Designation:</label>
                <form:input path="designation" id="designation" required="true" />
            </div>

           <%--  <div class="form-row">
                <label for="joiningDate">Joining Date:</label>
                <form:input path="joiningDate" id="joiningDate" required="true" />
            </div> --%>
            
            <div class="form-row">
    <label for="joiningDate">Joining Date:</label>
    <form:input path="joiningDate" id="joiningDate" required="true" oninput="validateJoiningDate()" />
    <div id="joiningDateError" style="color: red;"></div> <!-- Error message displayed here -->
</div>

            <div class="form-row">
    <label for="salary">Salary:</label>
    <form:input path="salary" id="salary" required="true" oninput="allowNumericInput(event)" />
</div>


            <button type="submit">Save</button>
        </form:form>

        <!-- Back Button -->
        <a href="/employees/all-employees?page=${currentPage-1}&size=5" class="back-button">Back to Employee List</a>
    </div>
    
</body>
</html>
