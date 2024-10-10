<?php
session_start();
if (!isset($_SESSION['idUsuario']) || $_SESSION['idRol'] != 1) {
    header("Location: login.php");
    exit();
}

// Información de la base de datos
$servername = "localhost";
$username = "id22308524_pasta0868";
$password = "Daniel_1602";
$dbname = "id22308524_login";

$dsn = "mysql:host=$servername;dbname=$dbname;charset=utf8mb4";

try {
    // Conexión a la base de datos
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error al conectar a la base de datos: " . $e->getMessage());
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    $idUsuario = $_SESSION['idUsuario'];
    $profile_picture = null;
    

    // Manejo de la subida de imagen
    if (isset($_FILES['profile_picture']) && $_FILES['profile_picture']['error'] == UPLOAD_ERR_OK) {
        $file_tmp_path = $_FILES['profile_picture']['tmp_name'];
        $file_name = $_FILES['profile_picture']['name'];
        $file_size = $_FILES['profile_picture']['size'];
        $file_type = $_FILES['profile_picture']['type'];
        $file_ext = pathinfo($file_name, PATHINFO_EXTENSION);

        // Directorio de destino para la imagen
        $upload_dir = 'uploads/';
        $new_file_name = $idUsuario . "_profile." . $file_ext;
        $dest_path = $upload_dir . $new_file_name;

        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);  // Crea la carpeta si no existe, con permisos adecuados
        }
        
        $dest_path = $upload_dir . $new_file_name;
        
        if (move_uploaded_file($file_tmp_path, $dest_path)) {
            $profile_picture = $new_file_name;  // Ruta para guardar en la base de datos
        } else {
            die("Error al subir la imagen.");
        }
        
        // Mover el archivo a la carpeta 'uploads'
        if (move_uploaded_file($file_tmp_path, $dest_path)) {
            $profile_picture = $new_file_name; // Ruta para guardar en la base de datos
        } else {
            die("Error al subir la imagen.");
        }
    }

    // Preparar la consulta SQL para actualizar el perfil
    $sql = "UPDATE usuarios SET nombre = :nombre, email = :email";
    
    // Si se subió una imagen, agregar la ruta a la consulta
    if ($profile_picture) {
        $sql .= ", profile_picture = :profile_picture";
    }

    $sql .= " WHERE id = :idUsuario";

    // Preparar la sentencia para ejecutar
    $stmt = $pdo->prepare($sql);

    // Vincular los valores
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':email', $email);
    if ($profile_picture) {
        $stmt->bindParam(':profile_picture', $profile_picture);
    }
    $stmt->bindParam(':idUsuario', $idUsuario);

    // Ejecutar la sentencia
    if ($stmt->execute()) {
        header("Location: admin.php");
        exit();
    } else {
        echo "Error al actualizar el perfil.";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        input, textarea {
            width: 100%;
            padding: 0.5rem;
            margin: 0.5rem 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            background-color: #fa5c2c;
            border: none;
            padding: 10px 20px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #e5b720;
        }

    </style>
</head>
<body>
    <div class="form-container">
        <h2>Editar Perfil</h2>
        <form method="POST" enctype="multipart/form-data">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="Juanes" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="juanes@example.com" required>

            <label for="profile_picture">Imagen de perfil:</label>
            <input type="file" id="profile_picture" name="profile_picture">

            <button type="submit">Guardar cambios</button>
        </form>
    </div>
</body>
</html>
