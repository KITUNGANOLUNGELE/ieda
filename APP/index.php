<?php
// header("Access-Control-Allow-Origin:*");
if (isset($_GET["user"]) && isset($_GET["pass"]) && $_GET["user"]=="IEDA" && $_GET["pass"]=="IEDADev@2024") {
    header("Content-Type: application/json");
    require_once __DIR__."/./routes/Routes.php";
    $route = new Routes();
    $route->getcontroller();
    
} else {
    echo json_encode(array("message"=>"Contactez IEDA dev"));
}
?>