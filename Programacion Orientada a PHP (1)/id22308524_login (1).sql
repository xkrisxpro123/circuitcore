-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 23-08-2024 a las 11:26:45
-- Versión del servidor: 10.5.20-MariaDB
-- Versión de PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `id22308524_login`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `ActualizarEstadoCotizacion` (IN `p_idCotizacion` INT, IN `p_estadoNuevo` VARCHAR(45))   BEGIN
    UPDATE cotizacion
    SET EstadoCotizacion = p_estadoNuevo
    WHERE idCotizacion = p_idCotizacion;
END$$

CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `EliminarUsuario` (IN `p_idUsuario` INT)   BEGIN
    DELETE FROM usuarios
    WHERE idUsuario = p_idUsuario;
END$$

CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `InsertarUsuario` (IN `p_nombreUsuario` VARCHAR(45), IN `p_correoElectronico` VARCHAR(45), IN `p_contrasena` VARCHAR(255), IN `p_idRol` INT)   BEGIN
    INSERT INTO usuarios (nombreUsuario, correoElectronico, contrasena, idRol)
    VALUES (p_nombreUsuario, p_correoElectronico, p_contrasena, p_idRol);
END$$

CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `ObtenerCotizacionesPorCliente` (IN `p_idCliente` INT)   BEGIN
    SELECT * FROM cotizacion
    WHERE cliente_idCliente = p_idCliente;
END$$

CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `ObtenerInsumosPorProyecto` (IN `p_idProyecto` INT)   BEGIN
    SELECT i.idInsumos, i.tipoInsumos, i.nombreInsumo
    FROM insumos i
    JOIN contrato c ON i.ingeniero_usuario_idUsuario = c.ingeniero_idIngeniero
    WHERE c.proyecto_idProyecto = p_idProyecto;
END$$

CREATE DEFINER=`id22308524_pasta0868`@`%` PROCEDURE `ObtenerUsuariosPorRol` (IN `p_nombreRol` VARCHAR(45))   BEGIN
    SELECT u.idUsuario, u.nombreUsuario, u.correoElectronico, r.nombreRol
    FROM usuarios u
    JOIN roles r ON u.idRol = r.idRol
    WHERE r.nombreRol = p_nombreRol;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `nitCliente` varchar(15) DEFAULT NULL,
  `usuario_idUsuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `constructor`
--

CREATE TABLE `constructor` (
  `idConstructor` int(11) NOT NULL,
  `proyectoAsignado` int(11) DEFAULT NULL,
  `proyecto_idProyecto` int(11) DEFAULT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido` varchar(45) DEFAULT NULL,
  `NumeroDeIdentificacion` varchar(45) DEFAULT NULL,
  `Rol` varchar(45) DEFAULT NULL,
  `DescuentosPorPrestamo` decimal(10,2) DEFAULT NULL,
  `DiasTrabajados` int(11) DEFAULT NULL,
  `CostoPorDia` decimal(10,2) DEFAULT NULL,
  `Especializacion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

CREATE TABLE `contrato` (
  `tipoContrato` varchar(45) DEFAULT NULL,
  `idContrato` int(11) NOT NULL,
  `ingeniero_idIngeniero` int(11) DEFAULT NULL,
  `proveedores_idProveedores` int(11) DEFAULT NULL,
  `usuario_idUsuario` int(11) DEFAULT NULL,
  `proyecto_idProyecto` int(11) DEFAULT NULL,
  `PartesInvolucradas` varchar(255) DEFAULT NULL,
  `CondicionesDePago` varchar(255) DEFAULT NULL,
  `Penalizaciones` varchar(255) DEFAULT NULL,
  `DescripcionDelProyecto` varchar(255) DEFAULT NULL,
  `ModificacionesYExcepciones` varchar(255) DEFAULT NULL,
  `GarantiasYSeguros` varchar(255) DEFAULT NULL,
  `DocumentacionAdjunta` varchar(255) DEFAULT NULL,
  `EstadoContrato` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `idCotizacion` int(11) NOT NULL,
  `contacto` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `tipoPago` varchar(45) DEFAULT NULL,
  `item` varchar(45) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `valorUnidad` decimal(10,2) DEFAULT NULL,
  `valorTotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `EstadoCotizacion` varchar(45) DEFAULT NULL,
  `cliente_idCliente` int(11) DEFAULT NULL,
  `administrador_idAdministrador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradasinventario`
--

CREATE TABLE `entradasinventario` (
  `idEntradasInventario` int(11) NOT NULL,
  `fechaEntrada` date DEFAULT NULL,
  `horaEntrada` time DEFAULT NULL,
  `insumos_idInsumos` int(11) DEFAULT NULL,
  `ingeniero_idIngeniero` int(11) DEFAULT NULL,
  `proveedores_idProveedores` int(11) DEFAULT NULL,
  `proyecto_idProyecto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `idInsumos` int(11) NOT NULL,
  `tipoInsumos` varchar(11) DEFAULT NULL,
  `nombreInsumo` varchar(45) DEFAULT NULL,
  `ingeniero_usuario_idUsuario` int(11) DEFAULT NULL,
  `proveedores_idProveedores` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecto`
--

CREATE TABLE `proyecto` (
  `idProyecto` int(11) NOT NULL,
  `tipoProyecto` varchar(45) DEFAULT NULL,
  `plazoProyecto` varchar(45) DEFAULT NULL,
  `insumosSobrantes` varchar(45) DEFAULT NULL,
  `ClienteProyecto` varchar(45) DEFAULT NULL,
  `SupervisorDeMantenimientoProyecto` varchar(45) DEFAULT NULL,
  `UbicacionProyecto` varchar(45) DEFAULT NULL,
  `InsumoProyecto` varchar(45) DEFAULT NULL,
  `DisponibilidadDeHorarios` varchar(45) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFinalizacionEstimada` date DEFAULT NULL,
  `EstadoProyecto` varchar(45) DEFAULT NULL,
  `Presupuesto` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `idRol` int(11) NOT NULL,
  `nombreRol` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`idRol`, `nombreRol`) VALUES
(1, 'Admin'),
(2, 'Constructor'),
(3, 'Ingeniero'),
(4, 'Proveedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidasinventario`
--

CREATE TABLE `salidasinventario` (
  `idSalidasInventario` int(11) NOT NULL,
  `fechaSalida` date DEFAULT NULL,
  `horaSalida` time DEFAULT NULL,
  `contrato_idContrato` int(11) DEFAULT NULL,
  `contrato_ingeniero_idIngeniero` int(11) DEFAULT NULL,
  `contrato_proveedores_idProveedores` int(11) DEFAULT NULL,
  `contrato_proyecto_idProyecto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesiones`
--

CREATE TABLE `sesiones` (
  `idSesion` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaExpiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(45) NOT NULL,
  `correoElectronico` varchar(45) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `idRol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombreUsuario`, `correoElectronico`, `contrasena`, `idRol`) VALUES
(13, 'soiese', 'soiese@gmail.com', '$2y$10$GdJmkf0SttbQBRyi/yT01.N3K3llJOk/FS2kXagog/IID2EK0PNdW', 1),
(14, 'Juaness', 'juanes.mv01@gmail.com', '$2y$10$jR3rvIRY7ao.ghyuUsHYeupSUPFGl8C5PQtXRHKt9j7xJHXN6WYIq', 1),
(15, 'Juaness', 'juanes.mv01@gmail.com', '$2y$10$HDAYjSVYQzAWxIeLrybkKur/JvnRJjPEfzk.g7HWFJS31MdP11rlW', 1),
(16, 'monica', 'monica@gmail.com', '$2y$10$851vknxqqefxUurXcFKbKeSCk88yadbGNksD3qsaVHqL2jWHgPNAy', 4),
(17, 'asd', 'asd@gmail.com', '$2y$10$OLa.nGo0o2vOmJX1BHVuOe9jRZ3/invoJCXz24jE.jSGmg5pDnyYC', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD KEY `usuario_idUsuario` (`usuario_idUsuario`);

--
-- Indices de la tabla `constructor`
--
ALTER TABLE `constructor`
  ADD PRIMARY KEY (`idConstructor`),
  ADD KEY `proyecto_idProyecto` (`proyecto_idProyecto`);

--
-- Indices de la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`idContrato`),
  ADD KEY `ingeniero_idIngeniero` (`ingeniero_idIngeniero`),
  ADD KEY `proveedores_idProveedores` (`proveedores_idProveedores`),
  ADD KEY `usuario_idUsuario` (`usuario_idUsuario`),
  ADD KEY `proyecto_idProyecto` (`proyecto_idProyecto`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`idCotizacion`),
  ADD KEY `cliente_idCliente` (`cliente_idCliente`),
  ADD KEY `administrador_idAdministrador` (`administrador_idAdministrador`);

--
-- Indices de la tabla `entradasinventario`
--
ALTER TABLE `entradasinventario`
  ADD PRIMARY KEY (`idEntradasInventario`),
  ADD KEY `insumos_idInsumos` (`insumos_idInsumos`),
  ADD KEY `ingeniero_idIngeniero` (`ingeniero_idIngeniero`),
  ADD KEY `proveedores_idProveedores` (`proveedores_idProveedores`),
  ADD KEY `proyecto_idProyecto` (`proyecto_idProyecto`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`idInsumos`),
  ADD KEY `ingeniero_usuario_idUsuario` (`ingeniero_usuario_idUsuario`),
  ADD KEY `proveedores_idProveedores` (`proveedores_idProveedores`);

--
-- Indices de la tabla `proyecto`
--
ALTER TABLE `proyecto`
  ADD PRIMARY KEY (`idProyecto`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `salidasinventario`
--
ALTER TABLE `salidasinventario`
  ADD PRIMARY KEY (`idSalidasInventario`),
  ADD KEY `contrato_idContrato` (`contrato_idContrato`),
  ADD KEY `contrato_ingeniero_idIngeniero` (`contrato_ingeniero_idIngeniero`),
  ADD KEY `contrato_proveedores_idProveedores` (`contrato_proveedores_idProveedores`),
  ADD KEY `contrato_proyecto_idProyecto` (`contrato_proyecto_idProyecto`);

--
-- Indices de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD PRIMARY KEY (`idSesion`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idRol` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `constructor`
--
ALTER TABLE `constructor`
  MODIFY `idConstructor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contrato`
--
ALTER TABLE `contrato`
  MODIFY `idContrato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `idCotizacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entradasinventario`
--
ALTER TABLE `entradasinventario`
  MODIFY `idEntradasInventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `idInsumos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proyecto`
--
ALTER TABLE `proyecto`
  MODIFY `idProyecto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `salidasinventario`
--
ALTER TABLE `salidasinventario`
  MODIFY `idSalidasInventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  MODIFY `idSesion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`usuario_idUsuario`) REFERENCES `usuarios` (`idUsuario`);

--
-- Filtros para la tabla `constructor`
--
ALTER TABLE `constructor`
  ADD CONSTRAINT `constructor_ibfk_1` FOREIGN KEY (`proyecto_idProyecto`) REFERENCES `proyecto` (`idProyecto`);

--
-- Filtros para la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `contrato_ibfk_1` FOREIGN KEY (`ingeniero_idIngeniero`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `contrato_ibfk_2` FOREIGN KEY (`proveedores_idProveedores`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `contrato_ibfk_3` FOREIGN KEY (`usuario_idUsuario`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `contrato_ibfk_4` FOREIGN KEY (`proyecto_idProyecto`) REFERENCES `proyecto` (`idProyecto`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`cliente_idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `cotizacion_ibfk_2` FOREIGN KEY (`administrador_idAdministrador`) REFERENCES `usuarios` (`idUsuario`);

--
-- Filtros para la tabla `entradasinventario`
--
ALTER TABLE `entradasinventario`
  ADD CONSTRAINT `entradasinventario_ibfk_1` FOREIGN KEY (`insumos_idInsumos`) REFERENCES `insumos` (`idInsumos`),
  ADD CONSTRAINT `entradasinventario_ibfk_2` FOREIGN KEY (`ingeniero_idIngeniero`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `entradasinventario_ibfk_3` FOREIGN KEY (`proveedores_idProveedores`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `entradasinventario_ibfk_4` FOREIGN KEY (`proyecto_idProyecto`) REFERENCES `proyecto` (`idProyecto`);

--
-- Filtros para la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD CONSTRAINT `insumos_ibfk_1` FOREIGN KEY (`ingeniero_usuario_idUsuario`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `insumos_ibfk_2` FOREIGN KEY (`proveedores_idProveedores`) REFERENCES `usuarios` (`idUsuario`);

--
-- Filtros para la tabla `salidasinventario`
--
ALTER TABLE `salidasinventario`
  ADD CONSTRAINT `salidasinventario_ibfk_1` FOREIGN KEY (`contrato_idContrato`) REFERENCES `contrato` (`idContrato`),
  ADD CONSTRAINT `salidasinventario_ibfk_2` FOREIGN KEY (`contrato_ingeniero_idIngeniero`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `salidasinventario_ibfk_3` FOREIGN KEY (`contrato_proveedores_idProveedores`) REFERENCES `usuarios` (`idUsuario`),
  ADD CONSTRAINT `salidasinventario_ibfk_4` FOREIGN KEY (`contrato_proyecto_idProyecto`) REFERENCES `proyecto` (`idProyecto`);

--
-- Filtros para la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
