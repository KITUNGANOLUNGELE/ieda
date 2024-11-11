<?php

include_once __DIR__ . "/../class/database.php";
class Utilisateur
{
    private $bdController;
    private $con;

    public  $nom;
    public $postnom;
    public $prenom;
    public $email;
    public $photo;
    public $id_camp;

    public $type;

    function __construct($bd)
    {
        $this->con = $bd;
        $this->bdController = new DatabaseControl("utilisateur", $this->con);
    }

    function afficher()
    {
        $tableau = $this->bdController->afficher("select * from");
        return $tableau;
    }

    function inserer(array $params)
    {
        try {
            if ($this->type === "su") {
                $res = $this->bdController->inserer(sqlinsert: "(email, nom, postnom, prenom, photo) values (?,?,?,?,?)", params: $params);
                $u = $this->bdController->affichagePerso("select * from utilisateur order by id_utilisateur desc limit 1", [])->fetch();
                if ($this->bdController->executer("insert into " . $this->type . " (id_utilisateur, mot_de_pass) values (?,?)", array($u["id_utilisateur"], md5("1234")))) {
                    $res = array("message" => "Utilisateur ajouté");
                    return $res;
                }
            } else if ($this->type !== "su" && $this->id_camp !== null) {
                $res = $this->bdController->inserer(sqlinsert: "(email, nom, postnom, prenom, photo) values (?,?,?,?,?)", params: $params);
                $u = $this->bdController->affichagePerso("select * from utilisateur order by id_utilisateur desc limit 1", [])->fetch();
                if ($this->bdController->executer("insert into " . $this->type . " (id_utilisateur, mot_de_pass, id_camp) values (?,?,?)", array($u["id_utilisateur"], md5("1234"), $this->id_camp))) {
                    $res = array("message" => "Utilisateur ajouté");
                    return $res;
                }
            } else {
                $res = array("message" => "Entrer toutes les informations");
                return $res;
            }
        } catch (\Throwable $th) {
            echo json_encode(array("message" => $th->getMessage()));
        }
    }

    function update(array $params)
    {
        $res = $this->bdController->update(sqlupdate: "email=?, nom=?, postnom=?, prenom=?, photo=? where id_utilisateur=?", params: $params);
        return $res;
    }
    function delete(array $params)
    {
        $res = $this->bdController->delete(sqldelete: "id_utilisateur=?", params: $params);
        return $res;
    }
    function auth($email, $mdp)
    {
        if ($user = $this->bdController->affichagePerso("select * from utilisateur inner join su on utilisateur.id_utilisateur = su.id_utilisateur where utilisateur.email=? and su.mot_de_pass=?", params: [$email, $mdp])->fetch()) {
            $controller = new DatabaseControl("su", $this->con);
            $controller->update("isloged='T' where id_su = ?", params: array($user["id_su"]));
            return array("token" => base64_encode(json_encode(array("id" => $user["id_utilisateur"], "email" => $user["email"]))), "role" => "admin","message" => "Bienvenu ".$user["nom"]);
        } elseif ($user = $this->bdController->affichagePerso("select * from utilisateur inner join logincampadmin on utilisateur.id_utilisateur = logincampadmin.id_utilisateur where utilisateur.email=? and logincampadmin.mot_de_pass=?", params: [$email, $mdp])->fetch()) {
            $controller = new DatabaseControl("logincampadmin", $this->con);
            $controller->update("isloged='T' where id_logincampadmin = ?", params: array($user["id_logincampadmin"]));
            return array("token" => base64_encode(json_encode(array("id" => $user["id_utilisateur"], "email" => $user["email"]))), "role" => "admin camp","message" => "Bienvenu ".$user["nom"]);
        } elseif ($user = $this->bdController->affichagePerso("select * from utilisateur inner join loginuser on utilisateur.id_utilisateur = loginuser.id_utilisateur where utilisateur.email=? and loginuser.mot_de_pass=?", params: [$email, $mdp])->fetch()) {
            $controller = new DatabaseControl("loginuser", $this->con);
            $controller->update("isloged='T' where id_loginuser = ?", params: array($user["id_loginuser"]));
            return array("token" => base64_encode(json_encode(array("id" => $user["id_utilisateur"], "email" => $user["email"]))), "role" => "user","message" => "Bienvenu ".$user["nom"]);
        } else {
            return array("message" => "Pas de compte utilisateur");
        }
    }
}
