<?php
session_start();
if (!isset($_SESSION['idUsuario']) || $_SESSION['idRol'] != 1) {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background: linear-gradient(45deg, #fad02c, #e55e20);
            padding: 3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 5px solid black;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        nav ul li {
            margin: 0 10px;
        }

        nav ul li a {
            text-decoration: none;
            color: black;
            padding: 10px 20px;
            background-color: white;
            border-radius: 20px;
            transition: background-color 1s;
        }

        nav ul li a:hover {
            background-color: #e6b134;
        }

        .container {
            flex: 1;
            padding: 2rem;
            text-align: center;
        }

        .admin-info {
            background-color: #333;
            color: white;
            padding: 2rem;
            border-radius: 20px;
            position: relative;
        }

        .admin-info img {
            width: 100px;
            height: 100px;
            margin-bottom: 1rem;
        }

        .admin-info p {
            margin: 1rem 0;
        }

        .admin-info button {
            background-color: #fa5c2c;
            border: none;
            padding: 10px 20px;
            color: black;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .admin-info button:hover {
            background-color: #e5b720;
        }

        .navbar {
            position: relative;
            display: inline-block;
        }

        .menu-button {
            background-color: #fa5c2c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .navbar:hover .dropdown-content {
            display: block;
        }

        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
<script>
function toggleMenu() {
    var dropdown = document.getElementById("dropdown");
    if (dropdown.style.display === "block") {
        dropdown.style.display = "none";
    } else {
        dropdown.style.display = "block";
    }
}
window.onclick = function(event) {
    if (!event.target.matches('.menu-button')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.style.display === "block") {
                openDropdown.style.display = "none";
            }
        }
    }
}

document.addEventListener('DOMContentLoaded', (event) => {
    fetch('login.php', { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            if (data.name) {
                document.getElementById('username').innerText = data.name;
            } else {
                document.getElementById('username').innerText = 'No autenticado';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('username').innerText = 'Error al cargar';
        });
});

// Cerrar sesión
function logout() {
    fetch('logout.php', {
        method: 'POST'
    }).then(response => {
        window.location.href = 'login.html';
    }).catch(error => {
        console.error('Error:', error);
    });
}


</script>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="#inicio">Inicio</a></li>
                <li><a href="#contactenos">Consultar Cotizaciones</a></li>
                <li><a href="#contratos">Contratos</a></li>
                <li><a href="#proyectos">Proyectos</a></li>
                <li><a href="#personal">Asignar Personal</a></li>
                <li><a href="#progreso">Progreso</a></li>
            </ul>
        </nav>
        <div class="navbar">
            <div class="menu">
                <button class="menu-button" onclick="toggleMenu()">☰ <span id="username">Cargando...</span></button>
                <div id="dropdown" class="dropdown-content">
                    <a href="profile_edit.php">Editar perfil</a>
                    <a href="#" onclick="logout()">Cerrar sesión</a>
                </div>
            </div>
        </div>
    </header>
    <div class="container">
        <div class="admin-info">
            <img src="https://via.placeholder.com/100" alt="Icon">
            <h2>INFORMACIÓN DEL ADMINISTRADOR</h2>
            <p>Soy juanes, estoy estudiando un tecnólogo de análisis y desarrollo de software y soy el admin de la empresa.</p>
            <a href="profile_edit.php"><button>EDITAR</button></a>
        </div>
    </div>
</body>
</html>
