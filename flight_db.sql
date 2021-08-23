-- Database: `flight_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `PID` int(11) NOT NULL,
  `Fname` varchar(20) NOT NULL,
  `Lname` varchar(20) NOT NULL,
  `Age` int(11) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone` int(10) NOT NULL,
  `FID` int(11) NOT NULL,
  `BID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE `details` (
  `FID` int(10) NOT NULL,
  `origin` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `time_departure` time NOT NULL,
  `time_arrival` time NOT NULL,
  `price` int(11) NOT NULL,
  `seat` int(20) NOT NULL,
  `travel_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`FID`, `origin`, `destination`, `time_departure`, `time_arrival`, `price`, `seat`, `travel_date`) VALUES
(1, 'Delhi', 'Mumbai', '16:00:00', '18:05:00', 2100, 20, '2021-08-24'),
(2, 'Delhi', 'Mumbai', '16:00:00', '18:00:00', 2000, 20, '2021-08-24'),
(3, 'Delhi', 'Kolkata', '17:00:00', '19:00:00', 2200, 20, '2021-08-24'),
(4, 'Delhi', 'Chennai', '18:00:00', '21:00:00', 2000, 20, '2021-08-24'),
(5, 'Delhi', 'Bangalore', '13:00:00', '15:40:00', 2800, 20, '2021-08-24'),
(6, 'Mumbai', 'Delhi', '10:00:00', '12:05:00', 2200, 20, '2021-08-24'),
(8, 'Mumbai', 'Kolkata', '11:00:00', '13:35:00', 2900, 20, '2021-08-24'),
(9, 'Mumbai', 'Chennai', '12:00:00', '13:50:00', 1500, 20, '2021-08-24'),
(10, 'Mumbai', 'Bangalore', '13:15:00', '14:55:00', 1800, 20, '2021-08-24'),
(11, 'Kolkata', 'Delhi', '04:30:00', '06:50:00', 2700, 20, '2021-08-24'),
(12, 'Kolkata', 'Mumbai', '06:00:00', '08:40:00', 3100, 20, '2021-08-24'),
(13, 'Kolkata', 'Chennai', '09:25:00', '11:40:00', 2700, 20, '2021-08-24'),
(14, 'Kolkata', 'Bangalore', '11:45:00', '14:25:00', 3500, 20, '2021-08-24'),
(15, 'Chennai', 'Delhi', '00:00:00', '02:50:00', 2000, 20, '2021-08-24'),
(16, 'Chennai', 'Mumbai', '02:00:00', '03:50:00', 1400, 20, '2021-08-24'),
(17, 'Chennai', 'Bangalore', '10:00:00', '11:00:00', 1200, 20, '2021-08-24'),
(18, 'Chennai', 'Kolkata', '09:00:00', '10:55:00', 2100, 20, '2021-08-24'),
(19, 'Bangalore', 'Mumbai', '03:00:00', '04:40:00', 1900, 20, '2021-08-24'),
(20, 'Bangalore', 'Delhi', '02:30:00', '05:05:00', 2900, 20, '2021-08-24'),
(21, 'Bangalore', 'Kolkata', '14:45:00', '17:15:00', 3100, 20, '2021-08-24'),
(22, 'Bangalore', 'Chennai', '15:20:00', '16:20:00', 1300, 20, '2021-08-24');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `AID` int(10) NOT NULL,
  `City` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`AID`, `City`) VALUES
(1, 'Delhi'),
(2, 'Bangalore'),
(3, 'Mumbai'),
(4, 'Kolkata'),
(5, 'Chennai');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`FID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`AID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
