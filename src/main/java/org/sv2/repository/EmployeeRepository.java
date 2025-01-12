package org.sv2.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.sv2.entity.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
	

	
	
}
