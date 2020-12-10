-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 10, 2020 at 03:00 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kanban`
--

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE IF NOT EXISTS `cards` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `column_id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cards_label_unique` (`label`),
  KEY `cards_column_id_foreign` (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `column_id`, `label`, `title`, `description`, `created_at`, `updated_at`) VALUES
(29, 13, 'jduu0jfu8v6uoawjc1b9st0m16t20dn', 'Card 1', 'some description', '2020-12-10 01:56:37', '2020-12-10 01:56:37'),
(30, 13, 'jspc451funlbnulqxzn3uow16cqbpy', 'Card 2', 'some description', '2020-12-10 01:56:56', '2020-12-10 01:56:56'),
(31, 13, 'k18u90000ir1dg50lx6kssbo19yqprq', 'Card 3', 'some description', '2020-12-10 01:57:07', '2020-12-10 01:57:07'),
(32, 13, 'k7gg83llm81ouq3zw1y3qrcl1izvkjj', 'Card 4', 'some description', '2020-12-10 01:57:15', '2020-12-10 01:57:15'),
(33, 13, 'kfarwrcykbf1xzjdbwbdr8dc1e1zb7b', 'Card 5', 'some description', '2020-12-10 01:57:25', '2020-12-10 01:57:25'),
(34, 13, 'kp3y2ipx4ot3sgyjiy9i3b1uwkok8', 'Card 6', 'some description', '2020-12-10 01:57:38', '2020-12-10 01:57:38'),
(35, 14, 'l1mbtvohacokn3pxcggh9npv76o3w', 'Card 7', 'some description', '2020-12-10 01:57:54', '2020-12-10 01:57:54'),
(36, 14, 'l91dp0px4zq11zb8ek1vm7652vmjlpn', 'Card 8', 'some description', '2020-12-10 01:58:04', '2020-12-10 01:58:04'),
(37, 14, 'lhdc0jfu8ja7ha3okkesrmeel02kn', 'Card 9', 'some description', '2020-12-10 01:58:15', '2020-12-10 01:58:15'),
(38, 14, 'lpibzgk5s41hdrnt283sgp8kxj6i', 'Card 10', 'some description', '2020-12-10 01:58:25', '2020-12-10 01:58:25'),
(39, 15, 'mevfs9cykir1o9esw91s44qkw1nvo9ig', 'Card 11', 'some description', '2020-12-10 01:58:58', '2020-12-10 01:58:58'),
(40, 15, 'morjwrcykfm2caiqeuwsv31nn6a7d', 'Card 12', 'some description', '2020-12-10 01:59:11', '2020-12-10 01:59:11'),
(41, 15, 'mxwhrweeecor1kgrw27awj613e9k8l', 'Card 13', 'some description', '2020-12-10 01:59:23', '2020-12-10 01:59:23');

-- --------------------------------------------------------

--
-- Table structure for table `columns`
--

DROP TABLE IF EXISTS `columns`;
CREATE TABLE IF NOT EXISTS `columns` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `column_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `columns`
--

INSERT INTO `columns` (`id`, `column_id`, `title`, `created_at`, `updated_at`) VALUES
(13, 'f2krambiqgq1r0ikzx12najbwy59bxj', 'Column 1', '2020-12-10 01:53:16', '2020-12-10 01:53:16'),
(14, 'fcvuy7777bf1yz480w1hp37nakna7xk', 'Column 2', '2020-12-10 01:53:29', '2020-12-10 01:53:29'),
(15, 'fletj2voi091p7xjf61tm7y5m1qrdo17', 'Column 3', '2020-12-10 01:53:40', '2020-12-10 01:53:40');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_12_09_085228_create_columns_table', 1),
(5, '2020_12_09_085251_create_cards_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_column_id_foreign` FOREIGN KEY (`column_id`) REFERENCES `columns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
