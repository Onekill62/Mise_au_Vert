
CREATE TABLE `affectation` (
  `box_id` int NOT NULL,
  `animal_id` int NOT NULL,
  `Date_fin` date DEFAULT NULL,
  `Regle` varchar(4) DEFAULT NULL,
  `Carnet_Vaccination` varchar(4) DEFAULT NULL,
  `Poids` varchar(50) DEFAULT NULL,
  `Age` varchar(50) DEFAULT NULL,
  `Vaccin_a_jour` varchar(4) DEFAULT NULL,
  `Vermifuge_a_jour` varchar(4) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `animal` (
  `id_Animal` int NOT NULL,
  `nom_animal` varchar(255) DEFAULT NULL,
  `id_proprietaire` int DEFAULT NULL,
  `id_espece` int DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `box` (
  `id_box` int NOT NULL,
  `superficie` int DEFAULT NULL,
  `id_TypeGardiennage` int DEFAULT NULL,
  `id_pension` int DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `date` (
  `Date` date NOT NULL
) ENGINE=InnoDB;


CREATE TABLE `espece` (
  `id_espece` int NOT NULL,
  `libelle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB;

INSERT INTO `espece` (`id_espece`, `libelle`) VALUES
(1, 'Chien'),
(2, 'Chat');

CREATE TABLE `parametres` (
  `Nom` varchar(50) DEFAULT NULL,
  `AdresseSiegeSocial` varchar(255) DEFAULT NULL,
  `NomDirigeant` varchar(255) DEFAULT NULL,
  `AdresseLogo` varchar(255) DEFAULT NULL,
  `PrixVaccin` double DEFAULT NULL,
  `PrixVermifuge` double DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `pension` (
  `id_pension` int NOT NULL,
  `ville_pension` varchar(255) DEFAULT NULL,
  `adresse_pension` varchar(255) DEFAULT NULL,
  `telephone_pension` varchar(255) DEFAULT NULL,
  `responsable_pension` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `nom_pension` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE `proprietaire` (
  `id_proprietaire` int NOT NULL,
  `nom_Propietaire` varchar(255) DEFAULT NULL,
  `prenom_Propietaire` varchar(255) DEFAULT NULL,
  `Adresse_Propietaire` varchar(255) DEFAULT NULL,
  `TELEPHONE_Propietaire` varchar(255) DEFAULT NULL,
  `email_Proprietaire` varchar(80) NOT NULL,
  `password_proprietaire` varchar(255) NOT NULL,
  `date_naissance_proprietaire` date DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `tarification` (
  `Pension_id` int NOT NULL,
  `Type_Gardiennage_id` int NOT NULL,
  `Tarif` double DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `typegardiennage` (
  `id_TypeGardiennage` int NOT NULL,
  `Libelle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE `affectation`
  ADD PRIMARY KEY (`box_id`,`animal_id`),
  ADD KEY `animal_id` (`animal_id`);

--
-- Indexes for table `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`id_Animal`),
  ADD KEY `id_proprietaire` (`id_proprietaire`),
  ADD KEY `id_espece` (`id_espece`);

--
-- Indexes for table `box`
--
ALTER TABLE `box`
  ADD PRIMARY KEY (`id_box`),
  ADD KEY `id_TypeGardiennage` (`id_TypeGardiennage`),
  ADD KEY `id_pension` (`id_pension`);

--
-- Indexes for table `date`
--
ALTER TABLE `date`
  ADD PRIMARY KEY (`Date`);

--
-- Indexes for table `espece`
--
ALTER TABLE `espece`
  ADD PRIMARY KEY (`id_espece`);

--
-- Indexes for table `pension`
--
ALTER TABLE `pension`
  ADD PRIMARY KEY (`id_pension`);

--
-- Indexes for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD PRIMARY KEY (`id_proprietaire`);

--
-- Indexes for table `tarification`
--
ALTER TABLE `tarification`
  ADD PRIMARY KEY (`Pension_id`,`Type_Gardiennage_id`),
  ADD KEY `Type_Gardiennage_id` (`Type_Gardiennage_id`);

--
-- Indexes for table `typegardiennage`
--
ALTER TABLE `typegardiennage`
  ADD PRIMARY KEY (`id_TypeGardiennage`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `animal`
--
ALTER TABLE `animal`
  MODIFY `id_Animal` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `box`
--
ALTER TABLE `box`
  MODIFY `id_box` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `espece`
--
ALTER TABLE `espece`
  MODIFY `id_espece` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pension`
--
ALTER TABLE `pension`
  MODIFY `id_pension` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `proprietaire`
--
ALTER TABLE `proprietaire`
  MODIFY `id_proprietaire` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `typegardiennage`
--
ALTER TABLE `typegardiennage`
  MODIFY `id_TypeGardiennage` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `affectation`
--
ALTER TABLE `affectation`
  ADD CONSTRAINT `affectation_ibfk_1` FOREIGN KEY (`box_id`) REFERENCES `box` (`id_box`),
  ADD CONSTRAINT `affectation_ibfk_2` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id_Animal`);

--
-- Constraints for table `animal`
--
ALTER TABLE `animal`
  ADD CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`id_proprietaire`) REFERENCES `proprietaire` (`id_proprietaire`),
  ADD CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`id_espece`) REFERENCES `espece` (`id_espece`);

--
-- Constraints for table `box`
--
ALTER TABLE `box`
  ADD CONSTRAINT `box_ibfk_1` FOREIGN KEY (`id_TypeGardiennage`) REFERENCES `typegardiennage` (`id_TypeGardiennage`),
  ADD CONSTRAINT `box_ibfk_2` FOREIGN KEY (`id_pension`) REFERENCES `pension` (`id_pension`);

--
-- Constraints for table `tarification`
--
ALTER TABLE `tarification`
  ADD CONSTRAINT `tarification_ibfk_1` FOREIGN KEY (`Pension_id`) REFERENCES `pension` (`id_pension`),
  ADD CONSTRAINT `tarification_ibfk_2` FOREIGN KEY (`Type_Gardiennage_id`) REFERENCES `typegardiennage` (`id_TypeGardiennage`);
COMMIT;
