-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2023 at 06:00 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `CSE-PLATFORM`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `complaint_id` int(11) NOT NULL,
  `complaint_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `complaint_content` varchar(200) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaint`
--

INSERT INTO `complaint` (`complaint_id`, `complaint_date`, `complaint_content`, `user_id`) VALUES
(1, '2023-04-20 15:42:02', '00 dd', 1),
(2, '2023-04-20 15:42:02', 'hello', 3),
(3, '2023-04-20 15:42:02', 'GG', 3);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(30) NOT NULL,
  `course_description` varchar(100) DEFAULT NULL,
  `course_type` int(11) NOT NULL CHECK (`course_type` in (1,2,3,4,5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_description`, `course_type`) VALUES
(1, 'math', 'math course', 1),
(2, 'java', 'java course', 1),
(3, 'DSP', 'DSP course :3', 1);

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

CREATE TABLE `list` (
  `course_id` int(11) NOT NULL,
  `user_Id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`course_id`, `user_Id`) VALUES
(1, 1),
(1, 2),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `material`
--

CREATE TABLE `material` (
  `material_id` int(11) NOT NULL,
  `material_name` varchar(30) NOT NULL,
  `material_description` varchar(100) DEFAULT NULL,
  `material_status` int(11) NOT NULL CHECK (`material_status` in (1,2,3)),
  `category` int(11) NOT NULL CHECK (`category` in (1,2,3,4,5)),
  `path` varchar(60) NOT NULL,
  `course_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `material`
--

INSERT INTO `material` (`material_id`, `material_name`, `material_description`, `material_status`, `category`, `path`, `course_id`, `submission_id`) VALUES
(1, 'java Lecture 1', 'Introduction to java', 1, 1, '/materials/java/lecture1.pdf', 1, 1),
(2, 'math Lecture 1', 'Introduction to math', 1, 1, '/materials/math/lecture1.pdf', 2, 1),
(3, 'DPS Lecture 1', 'Introduction to DSP', 1, 1, '/materials/DSP/lecture1.pdf', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `submission`
--

CREATE TABLE `submission` (
  `submission_id` int(11) NOT NULL,
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `submission_status` int(11) NOT NULL CHECK (`submission_status` in (1,2,3,4)),
  `submission_description` varchar(100) NOT NULL,
  `User_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submission`
--

INSERT INTO `submission` (`submission_id`, `submission_date`, `submission_status`, `submission_description`, `User_id`) VALUES
(1, '2023-04-20 15:40:35', 1, 'First assignment submission', 1),
(2, '2023-04-20 15:40:35', 1, 'math final', 2),
(3, '2023-04-20 15:40:35', 1, 'java mid', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_`
--

CREATE TABLE `user_` (
  `User_ID` int(11) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL CHECK (`email` like '%_@%.%'),
  `password` varchar(30) NOT NULL,
  `user_type` int(11) NOT NULL CHECK (`user_type` in (1,2)),
  `Confirmation_status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_`
--

INSERT INTO `user_` (`User_ID`, `user_name`, `email`, `password`, `user_type`, `Confirmation_status`) VALUES
(1, 'nedal', 'test@example.com', 'password', 1, 0),
(2, 'mohammad', 'mohammad@example.com', 'password', 1, 0),
(3, 'yousef', 'yousef@example.com', 'password', 1, 0),
(4, 'ABDULLMENEM', 'ABDAF@example.com', 'password', 2, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `complaint_user_fk` (`user_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_name` (`course_name`);

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`course_id`,`user_Id`),
  ADD KEY `list_user_fk` (`user_Id`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`material_id`),
  ADD UNIQUE KEY `path` (`path`),
  ADD KEY `material_user_fk` (`course_id`),
  ADD KEY `material_submission_fk` (`submission_id`);

--
-- Indexes for table `submission`
--
ALTER TABLE `submission`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `submission_user_fk` (`User_id`);

--
-- Indexes for table `user_`
--
ALTER TABLE `user_`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `material`
--
ALTER TABLE `material`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `submission`
--
ALTER TABLE `submission`
  MODIFY `submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_`
--
ALTER TABLE `user_`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
  ADD CONSTRAINT `complaint_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user_` (`User_ID`) ON DELETE CASCADE;

--
-- Constraints for table `list`
--
ALTER TABLE `list`
  ADD CONSTRAINT `list_course_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `list_user_fk` FOREIGN KEY (`user_Id`) REFERENCES `user_` (`User_ID`) ON DELETE CASCADE;

--
-- Constraints for table `material`
--
ALTER TABLE `material`
  ADD CONSTRAINT `material_submission_fk` FOREIGN KEY (`submission_id`) REFERENCES `submission` (`submission_id`),
  ADD CONSTRAINT `material_user_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- Constraints for table `submission`
--
ALTER TABLE `submission`
  ADD CONSTRAINT `submission_user_fk` FOREIGN KEY (`User_id`) REFERENCES `user_` (`User_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;