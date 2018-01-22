-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-01-2018 a las 10:21:22
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `kriblet`
--
CREATE DATABASE IF NOT EXISTS `kriblet` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `kriblet`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_FEEDS` (IN `_ID_user` INT(11))  NO SQL
    COMMENT 'GET articles'
SELECT 
	a.ID_article, a.title, 
    a.description, a.link, 
    a.image, a.date, 
    COUNT(ul1.ID_user_like) likes, 
    ul2.ID_user_like liked 
FROM article a 

LEFT JOIN user_like ul1 
ON 
	a.ID_article = ul1.FK_ID_article 

LEFT JOIN user_like ul2 
ON 
	a.ID_article = ul2.FK_ID_article AND ul2.FK_ID_user = _ID_user
GROUP BY a.title 
ORDER BY a.date$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `article`
--

CREATE TABLE `article` (
  `ID_article` int(11) NOT NULL,
  `link` varchar(500) NOT NULL,
  `title` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `image` varchar(500) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `article`
--

INSERT INTO `article` (`ID_article`, `link`, `title`, `date`, `image`, `description`) VALUES
(23, 'https://www.nytimes.com/2018/01/21/world/americas/venezuela-oscar-perez-nicolas-maduro.html?partner=rss&amp;emc=rss', 'Venezuela’s Most-Wanted Rebel Shared His Story, Just Before Death', '2018-01-22', 'https://static01.nyt.com/images/2018/01/22/world/22venezuela1/22venezuela1-moth.jpg', 'Óscar Pérez, the policeman who commandeered a helicopter and called on Venezuelans to rise up, spoke with The Times in the days and hours before he was killed.'),
(24, 'https://www.nytimes.com/2018/01/21/world/middleeast/trump-israel-us-conservatives.html?partner=rss&amp;emc=rss', 'The Interpreter: Trump’s Hard-Line Israel Position Exports U.S. Culture War Abroad', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/middleeast/20int-culturewar1/20int-culturewar1-moth.jpg', 'Picking sides in the Israeli-Palestinian conflict has long been taboo in American policy. Domestic politics best explain the president’s break with this practice.'),
(25, 'https://www.nytimes.com/2018/01/21/world/middleeast/turkey-syria-kurds.html?partner=rss&amp;emc=rss', 'Turkey Begins Ground Assault on Kurdish Enclave in Syria', '2018-01-22', 'https://static01.nyt.com/images/2018/01/22/world/22turkey1/22turkey1-moth.jpg', 'Turkish forces crossed the Syrian border into Afrin in an assault on Kurdish militias, amid growing international concern. Deaths were reported on both sides of the border.'),
(26, 'https://www.nytimes.com/2018/01/21/world/asia/afghanistan-hotel-attack.html?partner=rss&amp;emc=rss', 'Siege at Kabul Hotel Caps a Violent 24 Hours in Afghanistan', '2018-01-22', 'https://static01.nyt.com/images/2018/01/22/world/22afghanistan/22afghanistan-moth-v3.jpg', 'The Taliban attack at the Intercontinental Hotel left at least 18 dead, but the toll from assaults across four provinces of the country surpassed 50.'),
(27, 'https://www.nytimes.com/2018/01/21/world/europe/womens-marches-london-paris.html?partner=rss&amp;emc=rss', 'Women’s Marches Across the World, in Photos and Voices of Protest', '2018-01-21', 'https://static01.nyt.com/images/2018/01/20/world/00marchs-around-world-slide-VF72/00marchs-around-world-slide-VF72-moth.jpg', 'On the one-year anniversary of the women’s marches that protested President Trump’s election, #MeToo was also a common theme among those who participated in 2018.'),
(28, 'https://www.nytimes.com/2018/01/21/world/europe/germany-coalition-talks-spd.html?partner=rss&amp;emc=rss', 'Angela Merkel Spared Disaster, and German Coalition Talks to Continue', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22Germany4/22Germany4-moth.jpg', 'The Social Democrats will enter formal coalition talks with the chancellor’s Christian Democrats, but the party’s grass roots must approve a final deal.'),
(29, 'https://www.nytimes.com/2018/01/21/world/canada/peterborough-nafta-manufacturing.html?partner=rss&amp;emc=rss', 'Peterborough Journal: This City Once Made Much of What Canada Bought. But No More.', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/00peterborough1/00peterborough1-moth.jpg', 'With the closing of plants like a 126-year-old G.E. factory, many in Peterborough, Ontario, scoff at the idea that Nafta benefits only Canada and Mexico.'),
(30, 'https://www.nytimes.com/2018/01/21/world/asia/north-korea-pop-singer-olympics.html?partner=rss&amp;emc=rss', 'North Korean Pop Singer Leads Pre-Olympic Delegation to South', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22korea/22korea-moth.jpg', 'The advance team of North Koreans, headed by Hyon Song-wol, one of the North’s best-known propaganda singers, arrived in the South on Sunday.'),
(31, 'https://www.nytimes.com/2018/01/21/world/europe/serbia-kosovo-aleksandar-vucic.html?partner=rss&amp;emc=rss', 'A Death in Kosovo Stokes Fears and Threatens Peace', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22Kosovo1/22Kosovo1-moth.jpg', 'President Aleksander Vucic of Serbia made a hastily arranged visit to Kosovo to ease the fears of ethnic Serbs — fears that critics say he has stoked.'),
(32, 'https://www.nytimes.com/2018/01/21/world/americas/pope-francis-peru.html?partner=rss&amp;emc=rss', 'Pope Lauds Peru’s Young, but Stays Silent on Church Sex Abuse', '2018-01-22', 'https://static01.nyt.com/images/2018/01/22/world/22pope/22pope-moth.jpg', 'Ending his weeklong visit to Latin America, Francis did not address an abuse scandal by a Roman Catholic group based in Peru.'),
(33, 'https://www.nytimes.com/2018/01/21/world/europe/greece-macedonia.html?partner=rss&amp;emc=rss', 'Greeks Protest Over Neighbor’s Use of the Name Macedonia', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22greece1/22greece1-moth.jpg', 'Tens of thousands gathered at a rally in Thessaloniki amid talks by Greece and the Republic of Macedonia to settle the long dispute.'),
(34, 'https://www.nytimes.com/2018/01/21/world/middleeast/pence-jordan-king-abdullah.html?partner=rss&amp;emc=rss', 'Pence and Jordan’s King ‘Agree to Disagree’ on Jerusalem', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22Jordan/22Jordan-moth.jpg', 'Vice President Mike Pence met King Abdullah II amid rising tension between their two countries over President Trump’s recognition of Jerusalem as Israel’s capital.'),
(35, 'https://www.nytimes.com/2018/01/21/world/asia/fire-delhi-factory-bawana.html?partner=rss&amp;emc=rss', 'Fire Traps Workers in Delhi Factory, Killing at Least 17', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22India-fire-sub/22India-fire-sub-moth.jpg', 'Many workers were trapped on the upper floors as they were making firecrackers, although the police said the factory had been licensed to make plastic items.'),
(36, 'https://www.nytimes.com/2018/01/21/world/africa/democratic-republic-of-congo-protests.html?partner=rss&amp;emc=rss', 'Demonstrations Against Kabila in Congo Leave at Least 6 Dead', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/22Congo1/22Congo1-moth.jpg', 'Protesters gathered in the Democratic Republic of Congo for the second time in less than a month, demanding elections and an end to Joseph Kabila’s extended presidency.'),
(37, 'https://www.nytimes.com/2018/01/20/world/middleeast/iran-protests-corruption-banks.html?partner=rss&amp;emc=rss', 'How Corruption and Cronyism in Banking Fueled Iran’s Protests', '2018-01-21', 'https://static01.nyt.com/images/2018/01/21/world/21IranCorruption/21IranCorruption-moth-v2.jpg', 'Thousands lost their savings in the collapse of shady banks, part of a broader economic system plagued by insider dealing, mismanagement and inefficiency.'),
(38, 'https://www.nytimes.com/2018/01/20/world/asia/padmaavat-india-rajput.html?partner=rss&amp;emc=rss', 'Recipe for Ruckus in India: A Queen’s Honor, a New Film and Politics', '2018-01-20', 'https://static01.nyt.com/images/2018/01/20/world/asia/20explosivefilm1/20explosivefilm1-moth.jpg', 'Hindu extremists smashed up the film set, pulled the director’s hair and threatened to behead the lead actress. “Padmaavat,” the most potentially explosive Indian film in years, opens Thursday.'),
(39, 'https://www.nytimes.com/2018/01/20/world/asia/china-jinyintan-atomic-city.html?partner=rss&amp;emc=rss', 'Jinyintan Journal: Where China Built Its Bomb, Dark Memories Haunt the Ruins', '2018-01-20', 'https://static01.nyt.com/images/2018/01/21/world/21china-nuclear/00china-nuclear-1-moth.jpg', 'The birthplace of China’s nuclear arsenal is now a patriotic showpiece, celebrating its scientists as heroes. But traumatic parts of its history go unmentioned.'),
(40, 'https://www.nytimes.com/2018/01/20/world/americas/brazil-lula-bolsonaro-election.html?partner=rss&amp;emc=rss', 'News Analysis: Leftist Lion and Far-Right Provocateur Vie for Brazil Presidency', '2018-01-20', 'https://static01.nyt.com/images/2018/01/21/world/21brazil/21brazil-moth.jpg', 'As a wild, bitter contest to lead Brazil gets underway, the two front-runners are political opposites, one facing prison time and the other with a long history of incendiary remarks.'),
(41, 'https://www.nytimes.com/2018/01/21/world/australia/were-watching-the-men.html?partner=rss&amp;emc=rss', 'Australia Diary: We’re Watching the Men', '2018-01-21', 'https://static01.nyt.com/images/2018/01/22/world/australia/22AustraliaDiary_MenatWorkGif/22AustraliaDiary_MenatWorkGif-moth.jpg', 'As the #MeToo reckoning continues, a woman returning to Brisbane confronts the masculinity of work.'),
(42, 'https://www.nytimes.com/video/world/middleeast/100000005692497/deadly-siege-at-kabuls-largest-hotel.html?partner=rss&amp;emc=rss', 'Deadly Siege at Kabul\'s Largest Hotel', '2018-01-21', '', 'A 14-hour gun battle at the Intercontinental Hotel in Afghanistan’s capital left multiple people dead and wounded.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `last_update`
--

CREATE TABLE `last_update` (
  `ID_last_update` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `last_update`
--

INSERT INTO `last_update` (`ID_last_update`, `date`) VALUES
(2, '2018-01-20'),
(3, '2018-01-21'),
(6, '2018-01-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `ID_user` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `gender` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`ID_user`, `name`, `email`, `gender`) VALUES
(1, 'Valentín García', 'valentin.garcia05@hotmail.com', 'male'),
(4, 'Pedro', 'pedro@mail.com', 'male'),
(5, 'gato', 'gato@mail.com', 'female');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_like`
--

CREATE TABLE `user_like` (
  `ID_user_like` int(11) NOT NULL,
  `FK_ID_user` int(11) NOT NULL,
  `FK_ID_article` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_like`
--

INSERT INTO `user_like` (`ID_user_like`, `FK_ID_user`, `FK_ID_article`) VALUES
(8, 1, 40),
(5, 4, 40),
(6, 5, 40);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`ID_article`),
  ADD UNIQUE KEY `link` (`link`);

--
-- Indices de la tabla `last_update`
--
ALTER TABLE `last_update`
  ADD PRIMARY KEY (`ID_last_update`),
  ADD UNIQUE KEY `date` (`date`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `user_like`
--
ALTER TABLE `user_like`
  ADD PRIMARY KEY (`ID_user_like`),
  ADD UNIQUE KEY `UK_user_article` (`FK_ID_user`,`FK_ID_article`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `article`
--
ALTER TABLE `article`
  MODIFY `ID_article` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `last_update`
--
ALTER TABLE `last_update`
  MODIFY `ID_last_update` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `ID_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `user_like`
--
ALTER TABLE `user_like`
  MODIFY `ID_user_like` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
