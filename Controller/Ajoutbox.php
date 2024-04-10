<?php

include("../Modele/ScriptBox.php");

$tarif_box = htmlspecialchars($_POST["tarifs"]);
$superficie = htmlspecialchars($_POST["superficie"]);
$id_type_gardiennage = htmlspecialchars($_POST["idTypeGardiennage"]);


$compte = new ScriptBox();
$compte->ModifierBox($tarif_box, $superficie, $id_type_gardiennage);


?>