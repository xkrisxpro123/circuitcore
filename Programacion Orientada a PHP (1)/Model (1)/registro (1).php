<?php
$servername = "localhost";
$username = "id22308524_pasta0868";
$password = "Daniel_1602";
$dbname = "id22308524_login";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

$nombreUsuario = $_POST['nombreUsuario'];
$correoElectronico = $_POST['correoElectronico'];
$contrasena = password_hash($_POST['contrasena'], PASSWORD_DEFAULT);
$idRol = $_POST['idRol'];

$sql = "INSERT INTO usuarios (nombreUsuario, correoElectronico, contrasena, idRol) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sssi", $nombreUsuario, $correoElectronico, $contrasena, $idRol);

if ($stmt->execute()) {
    header("Location: login.html");
    exit();
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$stmt->close();
$conn->close();
?>

