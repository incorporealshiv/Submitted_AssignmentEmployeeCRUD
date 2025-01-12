package org.sv2.service;

import org.apache.el.stream.Optional;
import org.springframework.data.domain.Page;
import org.sv2.entity.Employee;

public interface IEmployeService {

	public Page<Employee> getEmployees(int page, int size);

	public void saveOrUpdateEmployee(Employee employee);

	public java.util.Optional<Employee> getEmployeeById(Long id);

	public void deleteEmployee(Long id);

}
