<?php
    class Routes{
        public function getcontroller(){
            $route = explode("/", $_SERVER["REQUEST_URI"])[3];
            require_once __DIR__."/../controller/".ucfirst($route)."Controller.php";
        }
    }
?>
