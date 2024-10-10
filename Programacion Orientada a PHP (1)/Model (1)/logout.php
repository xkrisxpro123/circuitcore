<?php
session_start();
session_destroy();  // Elimina la sesión actual
header("Location: login.html");  // Redirige al login después de cerrar sesión
exit();
?>
