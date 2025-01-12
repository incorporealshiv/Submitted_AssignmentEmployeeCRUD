package org.sv2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.sv2.entity.Employee;
import org.sv2.service.IEmployeService;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private IEmployeService service;

    @GetMapping("/all-employees")
    public String listEmployees(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            Model model) {
        try {
            Page<Employee> employeePage = service.getEmployees(page, size);
            model.addAttribute("employees", employeePage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("pageSize", size);
            model.addAttribute("totalPages", employeePage.getTotalPages());
            model.addAttribute("totalItems", employeePage.getTotalElements());
        } catch (Exception e) {
            model.addAttribute("error", "Error fetching employee data: " + e.getMessage());
            return "error"; // redirect to error page
        }
        return "employeeList";
    }

    @GetMapping("/new")
    public String showNewForm(Model model) {
        model.addAttribute("employee", new Employee());
        return "employeeForm";
    }

    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute Employee employee, Model model) {
        try {
            service.saveOrUpdateEmployee(employee);
            return "redirect:/employees/all-employees"; // Success, redirect to list
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", "Duplicate employee found: " + e.getMessage());
            return "employeeForm"; // Return to the form page with error
        } catch (Exception e) {
            model.addAttribute("error", "Error saving employee: " + e.getMessage());
            return "employeeForm"; // Return to the form page with error
        }
    }

    @GetMapping("/edit/{id}/{currentPage}")
    public String showEditForm(@PathVariable Long id, @PathVariable Integer currentPage, Model model) {
        try {
            Employee employee = service.getEmployeeById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid employee Id:" + id));
            model.addAttribute("employee", employee);
            model.addAttribute("currentPage", currentPage);
        } catch (Exception e) {
            model.addAttribute("error", "Error fetching employee data: " + e.getMessage());
            return "error"; // redirect to error page
        }
        return "editEmployeeForm";
    }

    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            service.deleteEmployee(id);
            return "redirect:/employees/all-employees"; // Success, redirect to list
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting employee: " + e.getMessage());
            return "redirect:/employees/error";  // Redirect to error page
        }
    }

    @GetMapping("/error")
    public String errorPage() {
        return "error"; // Return to error page
    }
}
