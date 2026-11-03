// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentData {

    // Structure
    struct Student {
        uint id;
        string name;
        uint age;
        string department;
    }

    // Array to store students
    Student[] public students;

    // Mapping: Student ID -> Student details
    mapping(uint => Student) private studentById;

    // Check whether student ID exists
    mapping(uint => bool) public studentExists;

    // Add student
    function addStudent(
        uint _id,
        string memory _name,
        uint _age,
        string memory _department
    ) public {

        require(!studentExists[_id], "Student ID already exists");

        Student memory newStudent = Student(
            _id,
            _name,
            _age,
            _department
        );

        // Store in array
        students.push(newStudent);

        // Store in mapping
        studentById[_id] = newStudent;

        studentExists[_id] = true;
    }

    // Get student using ID
    function getStudentById(uint _id)
        public
        view
        returns (
            uint,
            string memory,
            uint,
            string memory
        )
    {
        require(studentExists[_id], "Student not found");

        Student memory s = studentById[_id];

        return (
            s.id,
            s.name,
            s.age,
            s.department
        );
    }

    // Get total students
    function getStudentCount() public view returns (uint) {
        return students.length;
    }

    // Receive Ether
    receive() external payable {}

    // Fallback function
    fallback() external payable {}
}