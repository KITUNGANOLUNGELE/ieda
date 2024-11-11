-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 11 nov. 2024 à 07:31
-- Version du serveur : 10.4.25-MariaDB
-- Version de PHP : 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ieda`
--

-- --------------------------------------------------------

--
-- Structure de la table `besoin`
--

CREATE TABLE `besoin` (
  `id_besoin` bigint(20) NOT NULL,
  `desgnation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `besoinpdi`
--

CREATE TABLE `besoinpdi` (
  `id` bigint(20) NOT NULL,
  `id_besoin` bigint(20) NOT NULL,
  `matricule` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `camp`
--

CREATE TABLE `camp` (
  `id_camp` bigint(20) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `longitude` varchar(10) NOT NULL,
  `latitue` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `historique`
--

CREATE TABLE `historique` (
  `num` bigint(20) NOT NULL,
  `id_su` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `logincampadmin`
--

CREATE TABLE `logincampadmin` (
  `id_logicampadmin` bigint(20) NOT NULL,
  `id_camp` bigint(20) NOT NULL,
  `id_utilisateur` bigint(20) NOT NULL,
  `mot_de_pass` text NOT NULL,
  `isloged` varchar(1) DEFAULT 'F'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `loginuser`
--

CREATE TABLE `loginuser` (
  `id_loginuser` bigint(20) NOT NULL,
  `id_utilisateur` bigint(20) NOT NULL,
  `id_camp` bigint(20) NOT NULL,
  `mot_de_pass` text NOT NULL,
  `isloged` varchar(1) DEFAULT 'F'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `menage`
--

CREATE TABLE `menage` (
  `id_menage` bigint(20) NOT NULL,
  `designaiton` varchar(35) DEFAULT NULL,
  `id_camp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pdi`
--

CREATE TABLE `pdi` (
  `id_pdi` bigint(20) NOT NULL,
  `matricule` varchar(50) DEFAULT NULL,
  `nom` varchar(25) NOT NULL,
  `postnom` varchar(25) NOT NULL,
  `prenom` varchar(25) DEFAULT NULL,
  `photo` text DEFAULT NULL,
  `carte_recto` text DEFAULT NULL,
  `carte_verso` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pdimembre`
--

CREATE TABLE `pdimembre` (
  `matricule` varchar(50) NOT NULL,
  `id_menage` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pdiresponsable`
--

CREATE TABLE `pdiresponsable` (
  `matricule` varchar(50) NOT NULL,
  `id_menage` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pdisansmenage`
--

CREATE TABLE `pdisansmenage` (
  `matricule` varchar(50) NOT NULL,
  `id_camp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `su`
--

CREATE TABLE `su` (
  `id_su` bigint(20) NOT NULL,
  `id_utilisateur` bigint(20) NOT NULL,
  `mot_de_pass` text NOT NULL,
  `isloged` varchar(1) DEFAULT 'F'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `su`
--

INSERT INTO `su` (`id_su`, `id_utilisateur`, `mot_de_pass`, `isloged`) VALUES
(1, 1, '81dc9bdb52d04dc20036dbd8313ed055', 'T'),
(15, 12, '81dc9bdb52d04dc20036dbd8313ed055', 'F');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` bigint(20) NOT NULL,
  `email` text NOT NULL,
  `nom` varchar(25) NOT NULL,
  `postnom` varchar(25) NOT NULL,
  `prenom` varchar(25) DEFAULT NULL,
  `photo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `email`, `nom`, `postnom`, `prenom`, `photo`) VALUES
(1, 'hlungelehenock@gmail.com', 'Henock', 'Lungele', 'Henock', NULL),
(12, 'bwira@gmail.com', 'Achille', 'bwira', 'Blondy', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `besoin`
--
ALTER TABLE `besoin`
  ADD PRIMARY KEY (`id_besoin`);

--
-- Index pour la table `besoinpdi`
--
ALTER TABLE `besoinpdi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matricule` (`matricule`),
  ADD KEY `id_besoin` (`id_besoin`);

--
-- Index pour la table `camp`
--
ALTER TABLE `camp`
  ADD PRIMARY KEY (`id_camp`);

--
-- Index pour la table `historique`
--
ALTER TABLE `historique`
  ADD PRIMARY KEY (`num`),
  ADD KEY `id_su` (`id_su`);

--
-- Index pour la table `logincampadmin`
--
ALTER TABLE `logincampadmin`
  ADD PRIMARY KEY (`id_logicampadmin`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_camp` (`id_camp`);

--
-- Index pour la table `loginuser`
--
ALTER TABLE `loginuser`
  ADD PRIMARY KEY (`id_loginuser`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_camp` (`id_camp`);

--
-- Index pour la table `menage`
--
ALTER TABLE `menage`
  ADD PRIMARY KEY (`id_menage`),
  ADD KEY `id_camp` (`id_camp`);

--
-- Index pour la table `pdi`
--
ALTER TABLE `pdi`
  ADD PRIMARY KEY (`id_pdi`),
  ADD UNIQUE KEY `matricule` (`matricule`);

--
-- Index pour la table `pdimembre`
--
ALTER TABLE `pdimembre`
  ADD PRIMARY KEY (`matricule`),
  ADD KEY `id_menage` (`id_menage`);

--
-- Index pour la table `pdiresponsable`
--
ALTER TABLE `pdiresponsable`
  ADD PRIMARY KEY (`matricule`),
  ADD KEY `id_menage` (`id_menage`);

--
-- Index pour la table `pdisansmenage`
--
ALTER TABLE `pdisansmenage`
  ADD PRIMARY KEY (`matricule`),
  ADD KEY `id_camp` (`id_camp`);

--
-- Index pour la table `su`
--
ALTER TABLE `su`
  ADD PRIMARY KEY (`id_su`),
  ADD UNIQUE KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `email` (`email`) USING HASH;

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `besoin`
--
ALTER TABLE `besoin`
  MODIFY `id_besoin` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `besoinpdi`
--
ALTER TABLE `besoinpdi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `camp`
--
ALTER TABLE `camp`
  MODIFY `id_camp` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique`
--
ALTER TABLE `historique`
  MODIFY `num` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `logincampadmin`
--
ALTER TABLE `logincampadmin`
  MODIFY `id_logicampadmin` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `loginuser`
--
ALTER TABLE `loginuser`
  MODIFY `id_loginuser` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `menage`
--
ALTER TABLE `menage`
  MODIFY `id_menage` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pdi`
--
ALTER TABLE `pdi`
  MODIFY `id_pdi` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `su`
--
ALTER TABLE `su`
  MODIFY `id_su` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `besoinpdi`
--
ALTER TABLE `besoinpdi`
  ADD CONSTRAINT `besoinpdi_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `pdi` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `besoinpdi_ibfk_2` FOREIGN KEY (`id_besoin`) REFERENCES `besoin` (`id_besoin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `historique`
--
ALTER TABLE `historique`
  ADD CONSTRAINT `historique_ibfk_1` FOREIGN KEY (`id_su`) REFERENCES `su` (`id_su`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `logincampadmin`
--
ALTER TABLE `logincampadmin`
  ADD CONSTRAINT `logincampadmin_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `logincampadmin_ibfk_2` FOREIGN KEY (`id_camp`) REFERENCES `camp` (`id_camp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `loginuser`
--
ALTER TABLE `loginuser`
  ADD CONSTRAINT `loginuser_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loginuser_ibfk_2` FOREIGN KEY (`id_camp`) REFERENCES `camp` (`id_camp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `menage`
--
ALTER TABLE `menage`
  ADD CONSTRAINT `menage_ibfk_1` FOREIGN KEY (`id_camp`) REFERENCES `camp` (`id_camp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `pdimembre`
--
ALTER TABLE `pdimembre`
  ADD CONSTRAINT `pdimembre_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `pdi` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pdimembre_ibfk_2` FOREIGN KEY (`id_menage`) REFERENCES `menage` (`id_menage`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `pdiresponsable`
--
ALTER TABLE `pdiresponsable`
  ADD CONSTRAINT `pdiresponsable_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `pdi` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pdiresponsable_ibfk_2` FOREIGN KEY (`id_menage`) REFERENCES `menage` (`id_menage`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `pdisansmenage`
--
ALTER TABLE `pdisansmenage`
  ADD CONSTRAINT `pdisansmenage_ibfk_1` FOREIGN KEY (`matricule`) REFERENCES `pdi` (`matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pdisansmenage_ibfk_2` FOREIGN KEY (`id_camp`) REFERENCES `camp` (`id_camp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `su`
--
ALTER TABLE `su`
  ADD CONSTRAINT `su_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
