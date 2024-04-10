<?php
include_once(realpath(__DIR__ . "/../Controller/Connect.php"));
class ScriptBox
{
    private $superficie;
    private $tarif;
    private $id_box;
    public function afficherBox($id_pension, $id_typeGardiennage){
        $cnx = new Connect();
        $conn = $cnx->connexion();

        if($conn->connect_error){
            die("". $conn->connect_error);
        }

        $sqlstmt = $conn->prepare("SELECT id_box FROM box WHERE id_TypeGardiennage = ? AND id_pension = ?");
        $sqlstmt->bind_param("ii",$id_typeGardiennage,$id_pension);
        $sqlstmt->execute();
        $result = $sqlstmt->get_result();
        if($result->num_rows >0){
            $row = $result->fetch_assoc();
            $this->id_box = $row['id_box'];
        } else {

            return -1;
        }

        return $this->id_box;
    }


    public function getTypesBoxWithTarifSuperficie() {
        $cnx = new Connect();
        $conn = $cnx->connexion();
        if ($conn->connect_error) {
            die("La connexion a échoué : " . $conn->connect_error);
        }
    
        // Requête pour récupérer les types de gardiennage avec tarifs et superficie
        $sql = "SELECT t.id_TypeGardiennage AS id, t.Libelle AS libelle, ta.Tarif AS tarif, b.superficie AS superficie
                FROM typegardiennage t
                LEFT JOIN tarification ta ON t.id_TypeGardiennage = ta.Type_Gardiennage_id
                LEFT JOIN box b ON t.id_TypeGardiennage = b.id_TypeGardiennage";
        $result = $conn->query($sql);
    
        $typesBox = array();
    
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                // Stocker les types de gardiennage avec tarifs et superficie dans un tableau
                $typesBox[] = array(
                    'id' => $row['id'],
                    'libelle' => $row['libelle'],
                    'tarif' => $row['tarif'],
                    'superficie' => $row['superficie']
                );
            }
        }
    
        $conn->close();
    
        return $typesBox;
    }

    public function ModifierBox($superficie, $tarif, $id_type_gardiennage){

        $cnx = new Connect();
        $conn = $cnx->connexion();
    
        if($conn->connect_error) {
            die("". $conn->connect_error);
        }
        $stmt_tarification = $conn->prepare("UPDATE tarification SET Tarif = ? WHERE Type_Gardiennage_id = ?");
        $stmt_tarification->bind_param("ii", $tarif, $id_type_gardiennage);
    
        $stmt_box = $conn->prepare("UPDATE box SET superficie = ? WHERE id_TypeGardiennage = ?");
        $stmt_box->bind_param("ii", $superficie, $id_type_gardiennage);

        $tarif_updated = $stmt_tarification->execute();
        $superficie_updated = $stmt_box->execute();
    
        // Vérifier si les mises à jour sont réussies
        if($tarif_updated && $superficie_updated) {  
            header("location: ../View/EspacePension/GestionBox.php");
        } else {
            echo "Erreur lors de l'enregistrement : ". $conn->error;
        }
    
        // Fermer les déclarations et la connexion
        $stmt_tarification->close();
        $stmt_box->close();
        $conn->close();
    }
    
    

    
    
}