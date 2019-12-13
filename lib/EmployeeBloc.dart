// TODO1: imports

// TODO2: List of employees

// TODO3: Stream controllers

// TODO4: Stream Sink getter

// TODO5: Constructor - add data; listen to changes

// TODO6: Core functions

// TODO7: dispose

import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {

  // sink to add in pipe
  // stream to get data from pipe
  // by pipe i means data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.0),
    Employee(3, "Employee Tree", 30000.0),
    Employee(4, "Employee Four", 40000.0),
    Employee(5, "Employee Five", 50000.0),
    Employee(6, "Employee Six", 45000.0),
    Employee(7, "Employee Seven", 15000.0),
    Employee(8, "Employee Eigth", 35000.0),
    Employee(9, "Employee Nine", 45500.0),
    Employee(10, "Employee Ten", 25000.0)
  ];


  // stream controllers
  final _employeeListStreamController = StreamController<List<Employee>>();

  // for increment and decrement 
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // Stream Sink getters
  Stream<List<Employee>> get employeeListStream => 
    _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => 
    _employeeListStreamController.sink; 

  StreamSink<Employee> get employeeSalaryIncrement =>
    _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement => 
    _employeeSalaryDecrementStreamController.sink;

  // Constructor - add data; listen to changes
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  // Core functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20/100;
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20/100;
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  // dispose
  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeSalaryIncrementStreamController.close();
  }

}