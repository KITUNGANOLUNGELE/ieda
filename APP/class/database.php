<?php
class DatabaseControl
{
    private $table;
    private $con;

    function __construct($table, $con)
    {
        $this->table = $table;
        $this->con = $con;
    }
    function afficher($sql)
    {
        $stmt = $this->con->prepare($sql . " " . $this->table);
        $stmt->execute();
        return $stmt;
    }
    function affichagePerso($sql, array $params)
    {
        $stmt = $this->con->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    function inserer(string $sqlinsert, array $params)
    {
        try {
           
        $stmt = $this->con->prepare("insert into " . $this->table . " " . $sqlinsert);
        if ($stmt->execute($params)) {
            return array("message" => "Enregistrement reussi");
        } else {
            return array("message" => "Echec d'enregistrement");
        }
        } catch (\Throwable $th) {
            echo json_encode(array("message"=>$th->getMessage()));
        }
    }
    function executer(string $sql, array $params)
    {
        $stmt = $this->con->prepare($sql);
        return $stmt->execute($params);
    }
    function update(string $sqlupdate, array $params)
    {
        $stmt = $this->con->prepare("update " . $this->table . " set " . $sqlupdate);
        if ($stmt->execute($params)) {
            return array("message" => "Modification réussie");
        } else {
            return array("message" => "Echec de modification");
        }
    }
    function delete(string $sqldelete, array $params)
    {
        $stmt = $this->con->prepare("delete from" . $this->table . " " . $sqldelete);
        if ($stmt->execute($params)) {
            return array("message" => "Suppression réussie");
        } else {
            return array("message" => "Echec de Suppression");
        }
    }
}
