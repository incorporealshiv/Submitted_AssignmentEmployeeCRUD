package org.sv2.serviceimpl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.sv2.entity.Employee;
import org.sv2.repository.EmployeeRepository;
import org.sv2.service.IEmployeService;

@Service
public class EmployeeServiceImpl implements IEmployeService {

	@Autowired
	private EmployeeRepository employeeRepository;

	@Override
	public Page<Employee> getEmployees(int page, int size) {
		Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Order.desc("id")));
		return employeeRepository.findAll(pageable);
	}

	public void saveOrUpdateEmployee(Employee employee) {

		// If employee has an ID, it's an update, otherwise, it's an insert
		if (employee.getId() != null) {
			// If the ID exists, you can update the employee directly
			Employee existingEmployee = employeeRepository.findById(employee.getId())
					.orElseThrow(() -> new RuntimeException("Employee not found"));

			// Update fields if needed
			existingEmployee.setName(employee.getName());
			existingEmployee.setEmail(employee.getEmail());
			existingEmployee.setPhone(employee.getPhone());
			existingEmployee.setDepartment(employee.getDepartment());
			existingEmployee.setDesignation(employee.getDesignation());
			existingEmployee.setJoiningDate(employee.getJoiningDate());
			existingEmployee.setSalary(employee.getSalary());
			// Add any other field updates here

			// Save the updated employee
			employeeRepository.save(existingEmployee);
		} else {
			// If no ID is set, it's a new employee, so save it
			employeeRepository.save(employee);
		}
	}

	public Optional<Employee> getEmployeeById(Long id) {
		return (Optional<Employee>) employeeRepository.findById(id);
	}

	public void deleteEmployee(Long id) {
		employeeRepository.deleteById(id);
	}

}
