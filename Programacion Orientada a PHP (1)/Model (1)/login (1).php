<?php
session_start();

$servername = "localhost";
$username = "id22308524_pasta0868";
$password = "Daniel_1602";
$dbname = "id22308524_login";

$dsn = "mysql:host=$servername;dbname=$dbname;charset=utf8mb4";

try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $correoElectronico = $_POST['correoElectronico'];
    $contrasena = $_POST['contrasena'];

    $sql = "SELECT idUsuario, contrasena, idRol, nombreUsuario FROM usuarios WHERE correoElectronico = :correoElectronico";
    
    try {
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':correoElectronico', $correoElectronico, PDO::PARAM_STR);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row) {
            if (password_verify($contrasena, $row['contrasena'])) {
                $_SESSION['idUsuario'] = $row['idUsuario'];
                $_SESSION['idRol'] = $row['idRol'];
                $_SESSION['nombreUsuario'] = $row['nombreUsuario'];

                switch ($row['idRol']) {
                    case 1:
                        header("Location: admin.php");
                        break;
                    case 2:
                        header("Location: constructor.php");
                        break;
                    case 3:
                        header("Location: ingeniero.php");
                        break;
                    case 4:
                        header("Location: proveedor.php");
                        break;
                    default:
                        header("Location: login.php");
                        break;
                }
                exit();
            } else {
                echo "Contraseña incorrecta";
            }
        } else {
            echo "Usuario no encontrado";
        }
    } catch (PDOException $e) {
        echo "Error en la consulta: " . $e->getMessage();
    }
} else if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_SESSION['nombreUsuario'])) {
        echo json_encode(['name' => $_SESSION['nombreUsuario']]);
    } else {
        echo json_encode(['error' => 'Usuario no autenticado']);
    }
}
$pdo = null;
?>
