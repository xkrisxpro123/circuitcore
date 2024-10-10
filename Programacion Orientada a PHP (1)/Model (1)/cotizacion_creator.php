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

    // Verificar si se envió el formulario
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        // Recibir datos del formulario
        $contacto = $_POST['contacto'];
        $fecha = $_POST['fecha'];
        $ciudad = $_POST['ciudad'];
        $descuento = $_POST['descuento'];
        $tipoPago = $_POST['tipoPago'];
        $estadoCotizacion = $_POST['estadoCotizacion'];

        // Procesar items
        $items = $_POST['item'];
        $descripciones = $_POST['descripcion'];
        $cantidades = $_POST['cantidad'];
        $valoresUnidad = $_POST['valorUnidad'];

        // Insertar la cotización en la base de datoss
        $sqlCotizacion = "INSERT INTO cotizacion (contacto, fecha, ciudad, descuento, tipoPago, EstadoCotizacion) VALUES (?, ?, ?, ?, ?, ?)";
        $stmtCotizacion = $pdo->prepare($sqlCotizacion);
        $stmtCotizacion->execute([$contacto, $fecha, $ciudad, $descuento, $tipoPago, $estadoCotizacion]);

        // Obtener el ID de la cotización insertada
        $idCotizacion = $pdo->lastInsertId();

        $ivaTotal = 0; // Acumulador de IVA

        for ($i = 0; $i < count($items); $i++) {
            $item = $items[$i];
            $descripcion = $descripciones[$i];
            $cantidad = $cantidades[$i];
            $valorUnidad = $valoresUnidad[$i];

            // Calcular IVA (asumiendo que el IVA es del 19%)
            $iva = $valorUnidad * 0.19;
            $ivaTotal += $iva;

            // Actualizar la cotización con los ítems
            $sqlItem = "UPDATE cotizacion SET item = ?, descripcion = ?, cantidad = ?, valorUnidad = ? WHERE idCotizacion = ?";
            $stmtItem = $pdo->prepare($sqlItem);
            $stmtItem->execute([$item, $descripcion, $cantidad, $valorUnidad, $idCotizacion]);
        }

        // Aquí puedes guardar el IVA total en una tabla si es necesario o actualizar la cotización

        echo "Cotización guardada correctamente.";
    }
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cotización</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<form method="POST" action="ingeniero.php">
    <label for="contacto">Contacto:</label>
    <input type="text" id="contacto" name="contacto" required>

    <label for="fecha">Fecha:</label>
    <input type="date" id="fecha" name="fecha" required>

    <label for="ciudad">Ciudad:</label>
    <input type="text" id="ciudad" name="ciudad" required>

    <label for="descuento">Descuento:</label>
    <input type="number" id="descuento" name="descuento" value="0" required>

    <label for="tipoPago">Tipo de Pago:</label>
    <input type="text" id="tipoPago" name="tipoPago" required>

    <label for="estadoCotizacion">Estado de la Cotización:</label>
    <select id="estadoCotizacion" name="estadoCotizacion">
        <option value="pendiente">Pendiente</option>
        <option value="aprobada">Aprobada</option>
        <option value="rechazada">Rechazada</option>
    </select>

    <h3>Items de Cotización</h3>

    <label for="item">Item:</label>
    <input type="text" id="item" name="item[]" required>

    <label for="descripcion">Descripción:</label>
    <textarea id="descripcion" name="descripcion[]" required></textarea>

    <label for="cantidad">Cantidad:</label>
    <input type="number" id="cantidad" name="cantidad[]" required>

    <label for="valorUnidad">Valor Unidad:</label>
    <input type="number" step="0.01" id="valorUnidad" name="valorUnidad[]" required>

    <button type="submit">Guardar Cotización</button>
</form>

</body>
</html>
