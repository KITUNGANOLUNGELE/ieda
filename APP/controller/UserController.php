<?php
include_once __DIR__ . "/../models/Utilisateur.php";
require_once __DIR__ . "/../config/Database.php";


$db = new Database();
$user = new Utilisateur($db->getConnection());
$state = explode("/", $_SERVER["REQUEST_URI"])[4];
$methode = $_SERVER["REQUEST_METHOD"];

switch ($methode) {
    case 'GET':
        switch ($state) {
            case 'get':
                $res = $user->afficher()->fetchAll();
                echo (json_encode($res));
                break;
            default:
                header("HTTP/1.1 500 not allowed");
                break;
        }
        break;
    case 'POST':
        switch ($state) {
                //insertion
            case 'auth':
                $data = json_decode(file_get_contents("php://input"));
                $res = $user->auth(htmlentities(htmlspecialchars(trim($data->email))), htmlentities(htmlspecialchars(md5($data->mdp))));
                echo json_encode($res);
                break;
            case  'insert':
                $data = json_decode(file_get_contents("php://input"));
                $user->nom = isset($data->nom) ?  htmlentities(htmlspecialchars(trim($data->nom))) : null;
                $user->postnom = isset($data->postnom) ? htmlentities(htmlspecialchars(trim($data->postnom))) : null;
                $user->prenom =isset($data->prenom) ? htmlentities(htmlspecialchars(trim($data->prenom))) : null;
                $user->email =isset($data->email) ? htmlspecialchars(htmlentities($data->email)) : null;
                $user->type = isset($data->type) ? htmlspecialchars(htmlentities(trim($data->type))) : null;
                $user->photo = null;
                $user->id_camp = isset($data->id_camp) ? htmlspecialchars(htmlentities(trim($data->id_camp))) : null;
                $res = $user->inserer(array($user->email, $user->nom, $user->postnom, $user->prenom, $user->photo));
                echo json_encode($res);
                break;

            default:
                header("HTTP/1.1 500 not allowed");
                break;
        }
        # code...
        break;

    default:
        header("HTTP/1.1 200 allowed");
        break;
}
