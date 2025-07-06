-- Forward Engineering Script for University Database

-- -----------------------------------------------------
-- Create Schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`college_id`));


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(75) NOT NULL,
  `department_code` VARCHAR(4) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  CONSTRAINT `fk_department_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`));


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  CONSTRAINT `fk_course_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`));


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`));


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR NOT NULL,
  `term` ENUM('Fall', 'Winter', 'Spring', 'Summer') NOT NULL,
  PRIMARY KEY (`term_id`));


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_num` INT NOT NULL,
  `capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  CONSTRAINT `fk_section_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`),
  CONSTRAINT `fk_section_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`),
  CONSTRAINT `fk_section_term`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`));


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F', 'O') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(2) NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`student_id`));


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  CONSTRAINT `fk_enrollment_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`),
  CONSTRAINT `fk_enrollment_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`));


-- -----------------------------------------------------
-- Insert Statements
-- -----------------------------------------------------

-- Populate College Table
INSERT INTO `college` (`college_name`) VALUES
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');

-- Populate Department Table
INSERT INTO `department` (`department_name`, `department_code`, `college_id`) VALUES
('Computer Information Technology', 'CIT', 1),
('Economics', 'ECON', 2),
('Humanities and Philosophy', 'HUM', 3);

-- Populate Course Table
INSERT INTO `course` (`course_num`, `course_title`, `credits`, `department_id`) VALUES
(111, 'Intro to Databases', 3, 1),
(388, 'Econometrics', 4, 2),
(150, 'Micro Economics', 3, 2),
(376, 'Classical Heritage', 2, 3);

-- Populate Faculty Table
INSERT INTO `faculty` (`faculty_fname`, `faculty_lname`) VALUES
('Marty', 'Morring'),
('Nate', 'Nathan'),
('Ben', 'Barrus'),
('John', 'Jensen'),
('Bill', 'Barney');

-- Populate Term Table
INSERT INTO `term` (`year`, `term`) VALUES
('2019', 'Fall'),
('2018', 'Winter');

-- Populate Section Table
INSERT INTO `section` (`section_num`, `capacity`, `course_id`, `faculty_id`, `term_id`) VALUES
(1, 30, 1, 1, 1),
(1, 50, 3, 2, 1),
(2, 50, 3, 2, 1),
(1, 35, 2, 3, 1),
(1, 30, 4, 4, 1),
(2, 30, 1, 1, 2),
(3, 35, 1, 5, 2),
(1, 50, 3, 2, 2),
(2, 50, 3, 2, 2),
(1, 30, 4, 4, 2);

-- Populate Student Table
INSERT INTO `student` (`first_name`, `last_name`, `gender`, `city`, `state`, `birthdate`) VALUES
('Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
('Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
('Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
('Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
('Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
('Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
('Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
('Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
('Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
('Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

-- Populate Enrollment Table
INSERT INTO `enrollment` (`student_id`, `section_id`) VALUES
(6, 7),
(7, 6),
(7, 8),
(7, 10),
(4, 5),
(9, 9),
(2, 4),
(3, 4),
(5, 4),
(5, 5),
(1, 1),
(1, 3),
(8, 9),
(10, 6);