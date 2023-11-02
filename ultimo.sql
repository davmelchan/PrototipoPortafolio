-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-11-2023 a las 18:47:30
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ultimo`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `evalucionEntrega` ()   begin
	select IdEvaluacionEntrega,evaluaciones.Titulo,concat(usuarios.Nombre,' ',usuarios.Apellido) as Nombre,Observacion,Material as Nombre from evaluacionentregas inner join evaluaciones 
on evaluacionentregas.IdEvaluacion = evaluaciones.IdEvaluacion
inner join usuarios on evaluacionentregas.IdAlumno = usuarios.Idusuarios;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Guardar` ()   begin
	Declare v1 int default 0;
    declare v2 int;
    set v2 = (Select count(*) from aspectosevaluacion);
    While v1 < v2
    Do
		insert into relacionvas(IdAlumno,IdAspectoEvaluacion,IdSupervision,IdValoracion)
        values(2,(v1+1),1,4);
        
        
		SET v1 = v1 + 1;
        end while;
	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Guardar1` ()   begin
	Declare v1 int default 0;
    declare v2 int;
    set v2 = (Select count(*) from usuarios);
    select v2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimiento` (IN `letra` CHAR)   begin
 select * from usuarios where Nombre like concat('%',letra,'%');	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccion` ()   begin
	select usuarios.Nombre,aspectosevaluacion.NombreAspectos,valoracion.NombreValoracion,supervision.NumVisita as Visita from relacionvas inner join usuarios on relacionvas.IdAlumno = usuarios.Idusuarios
	inner join aspectosevaluacion on relacionvas.IdAspectoEvaluacion = aspectosevaluacion.IdAspectosEvaluacion
	inner join supervision on relacionvas.IdSupervision = supervision.IdSupervision 
	inner join valoracion on relacionvas.IdValoracion = valoracion.IdValoracion;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `idActividad` int(11) NOT NULL,
  `NombreActividad` varchar(250) DEFAULT NULL,
  `Estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`idActividad`, `NombreActividad`, `Estado`) VALUES
(1, 'Exposicion Creativa', 0),
(2, 'Prueba diagnostica', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos`
--

CREATE TABLE `archivos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `fecha_create` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_carpeta` int(11) NOT NULL,
  `IdCategoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `archivos`
--

INSERT INTO `archivos` (`id`, `nombre`, `tipo`, `fecha_create`, `id_carpeta`, `IdCategoria`) VALUES
(1, 'proyectofinal (1).sql', 'application/octet-stream', '2023-09-05 02:03:46', 1, 3),
(2, 'beca.pdf', 'application/pdf', '2023-09-05 02:04:17', 2, 2),
(3, 'beca.pdf', 'application/pdf', '2023-09-05 02:23:32', 3, 3),
(4, 'proyectofinal (4).sql', 'application/octet-stream', '2023-09-05 02:24:13', 3, 3),
(5, 'LICENSE.txt', 'text/plain', '2023-09-05 02:24:52', 4, 2),
(6, 'progit.pdf', 'application/pdf', '2023-09-05 02:25:10', 4, 2),
(7, 'style.css', 'text/css', '2023-09-05 02:25:39', 5, 1),
(8, 'index.html', 'text/html', '2023-09-05 02:25:51', 5, 1),
(9, 'beca (3).pdf', 'application/pdf', '2023-09-05 02:26:31', 5, 1),
(11, 'Desktop - 1.png', 'image/png', '2023-11-02 17:01:15', 7, 2),
(12, 'Desktop - 2.png', 'image/png', '2023-11-02 17:04:04', 6, 1),
(13, 'iPhone 8 - 1.png', 'image/png', '2023-11-02 17:28:13', 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspectosevaluacion`
--

CREATE TABLE `aspectosevaluacion` (
  `IdAspectosEvaluacion` int(11) NOT NULL,
  `NombreAspectos` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aspectosevaluacion`
--

INSERT INTO `aspectosevaluacion` (`IdAspectosEvaluacion`, `NombreAspectos`) VALUES
(1, 'Puntualidad y asistencia  del Practicante al centro'),
(2, 'Presentación personal al centro de práctica'),
(3, 'Comportamiento y ética profesional '),
(4, 'Actitud mostrada con el personal docente y administrativo del centro de práctica'),
(5, 'Actitud mostrada  con los alumnos'),
(6, 'Responsabilidad en la realización de las tareas planificadas'),
(7, 'Cumplimiento de las actividades planificadas en el trabajo colaborativo'),
(8, 'Interés y respeto por el campo laboral observado'),
(9, 'Respeto hacia los compañeros de prácticas'),
(10, 'Respeto hacia el docente tutor'),
(11, 'Respeto hacia el docente titular');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carpetas`
--

CREATE TABLE `carpetas` (
  `IdCarpeta` int(11) NOT NULL,
  `NombreCarpeta` varchar(255) NOT NULL,
  `Fecha_carpeta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Id_usuario` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `IdCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carpetas`
--

INSERT INTO `carpetas` (`IdCarpeta`, `NombreCarpeta`, `Fecha_carpeta`, `Id_usuario`, `estado`, `IdCategoria`) VALUES
(1, 'Diario#1', '2023-09-05 02:03:39', 2, 1, 3),
(2, 'Doc#1', '2023-09-05 02:04:05', 2, 1, 2),
(3, 'Diario#1', '2023-09-05 02:23:26', 4, 1, 3),
(4, 'Doc1', '2023-09-05 02:24:39', 4, 1, 2),
(5, 'P1', '2023-09-05 02:25:24', 4, 1, 1),
(6, 'asdf', '2023-11-02 15:05:25', 2, 1, 1),
(7, 'asdf55', '2023-11-02 17:00:29', 2, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoriaarchivos`
--

CREATE TABLE `categoriaarchivos` (
  `IdCategoria` int(11) NOT NULL,
  `NombreCategoria` varchar(200) NOT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoriaarchivos`
--

INSERT INTO `categoriaarchivos` (`IdCategoria`, `NombreCategoria`, `Estado`) VALUES
(1, 'Guias Practicas', 1),
(2, 'Documentos practicas', 1),
(3, 'Diarios', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_archivos`
--

CREATE TABLE `detalle_archivos` (
  `id` int(11) NOT NULL,
  `fecha_add` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `correo` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `id_carpeta` int(11) NOT NULL,
  `id_archivo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `Idcategoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_grupo`
--

CREATE TABLE `docente_grupo` (
  `IdDocenteGrupo` int(11) NOT NULL,
  `Id_Docente` int(11) NOT NULL,
  `Id_Grupo` int(11) NOT NULL,
  `Estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docente_grupo`
--

INSERT INTO `docente_grupo` (`IdDocenteGrupo`, `Id_Docente`, `Id_Grupo`, `Estado`) VALUES
(1, 3, 4, 0),
(2, 3, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacionentregas`
--

CREATE TABLE `evaluacionentregas` (
  `IdEvaluacionEntrega` int(11) NOT NULL,
  `IdEvaluacion` int(11) DEFAULT NULL,
  `IdAlumno` int(11) DEFAULT NULL,
  `Observacion` varchar(255) DEFAULT NULL,
  `Material` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacionentregas`
--

INSERT INTO `evaluacionentregas` (`IdEvaluacionEntrega`, `IdEvaluacion`, `IdAlumno`, `Observacion`, `Material`) VALUES
(1, 1, 2, 'Tema un poco complicado', 'Imagen');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `IdEvaluacion` int(11) NOT NULL,
  `Titulo` varchar(255) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Puntaje` int(11) NOT NULL,
  `IdUnidad` int(11) NOT NULL,
  `IdTipoEvaluacion` int(11) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`IdEvaluacion`, `Titulo`, `Fecha`, `Puntaje`, `IdUnidad`, `IdTipoEvaluacion`, `Descripcion`) VALUES
(1, 'Enseñanza Practica', '2023-09-29 00:00:00', 20, 1, 2, 'Evidencia de los conocimientos adquiridos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `IdGenero` int(11) NOT NULL,
  `Genero` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`IdGenero`, `Genero`) VALUES
(1, 'Masculino'),
(2, 'Femenino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `IdGrupo` int(11) NOT NULL,
  `NombreGrupo` varchar(250) NOT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`IdGrupo`, `NombreGrupo`, `Estado`) VALUES
(1, 'Grupo1', 1),
(3, 'Skarleth2', 1),
(4, 'Skarleth', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horas`
--

CREATE TABLE `horas` (
  `IdHoras` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `IdEstudiante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `idNotas` int(11) NOT NULL,
  `Puntaje` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `IdEvaluacionEntrega` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`idNotas`, `Puntaje`, `Fecha`, `IdEvaluacionEntrega`) VALUES
(1, 15, '2023-09-29', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodo`
--

CREATE TABLE `periodo` (
  `idperiodo` int(11) NOT NULL,
  `NombrePeriodo` varchar(45) DEFAULT NULL,
  `Estado` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `periodo`
--

INSERT INTO `periodo` (`idperiodo`, `NombrePeriodo`, `Estado`) VALUES
(1, 'II-SEMESTRE-2024', 0),
(2, 'II-SEMESTRE-2025', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relacionvas`
--

CREATE TABLE `relacionvas` (
  `IdRelacion` int(11) NOT NULL,
  `IdAlumno` int(11) DEFAULT NULL,
  `IdAspectoEvaluacion` int(11) DEFAULT NULL,
  `IdSupervision` int(11) DEFAULT NULL,
  `IdValoracion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `relacionvas`
--

INSERT INTO `relacionvas` (`IdRelacion`, `IdAlumno`, `IdAspectoEvaluacion`, `IdSupervision`, `IdValoracion`) VALUES
(2, 2, 1, 1, 4),
(3, 2, 2, 1, 4),
(4, 2, 3, 1, 4),
(5, 2, 4, 1, 4),
(6, 2, 5, 1, 4),
(7, 2, 6, 1, 4),
(8, 2, 7, 1, 4),
(9, 2, 8, 1, 4),
(10, 2, 9, 1, 4),
(11, 2, 10, 1, 4),
(12, 2, 11, 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IdRol` int(11) NOT NULL,
  `NombreRol` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IdRol`, `NombreRol`) VALUES
(1, 'Administrador'),
(2, 'Maestro'),
(3, 'Estudiante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervision`
--

CREATE TABLE `supervision` (
  `IdSupervision` int(11) NOT NULL,
  `ProfesorId` int(11) DEFAULT NULL,
  `NumVisita` int(11) DEFAULT NULL,
  `FechaVisita` date DEFAULT NULL,
  `Observacion` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `supervision`
--

INSERT INTO `supervision` (`IdSupervision`, `ProfesorId`, `NumVisita`, `FechaVisita`, `Observacion`) VALUES
(1, 3, 1, '2023-09-29', 'Se ha observado que ha cumplido su cometido con sus practicas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_empresa`
--

CREATE TABLE `tbl_empresa` (
  `id_empresa` int(11) NOT NULL,
  `Nombre_empresa` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_empresa`
--

INSERT INTO `tbl_empresa` (`id_empresa`, `Nombre_empresa`) VALUES
(1, 'Keiser University');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoevaluacion`
--

CREATE TABLE `tipoevaluacion` (
  `IdTipoEvaluacion` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipoevaluacion`
--

INSERT INTO `tipoevaluacion` (`IdTipoEvaluacion`, `Nombre`) VALUES
(1, 'Conceptuales'),
(2, 'Procedimentales'),
(3, 'Actitudinales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades`
--

CREATE TABLE `unidades` (
  `IdUnidad` int(11) NOT NULL,
  `NombreUnidad` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidades`
--

INSERT INTO `unidades` (`IdUnidad`, `NombreUnidad`) VALUES
(1, 'Etica humana'),
(2, 'Introduccion a la PFF'),
(3, 'Integracion al centro de practica'),
(4, 'Desempeño de las funciones y cargos en el centro de practica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Idusuarios` int(11) NOT NULL,
  `Nombre` varchar(250) NOT NULL,
  `Apellido` varchar(250) NOT NULL,
  `Direccion` varchar(500) NOT NULL,
  `GeneroId` int(11) NOT NULL,
  `Cedula` varchar(25) NOT NULL,
  `Carnet` varchar(50) NOT NULL,
  `FotoRuta` varchar(500) DEFAULT NULL,
  `Activo` int(11) NOT NULL DEFAULT 1,
  `IdRol` int(11) NOT NULL,
  `Correo` varchar(200) NOT NULL,
  `Clave` varchar(100) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Id_docente` int(11) DEFAULT NULL,
  `Id_Empresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Idusuarios`, `Nombre`, `Apellido`, `Direccion`, `GeneroId`, `Cedula`, `Carnet`, `FotoRuta`, `Activo`, `IdRol`, `Correo`, `Clave`, `Telefono`, `Id_docente`, `Id_Empresa`) VALUES
(1, 'David', 'Martinez', 'La concepcion Masaya Br.Macario Brenes', 1, 'XXX-XXXXXX-XXXX', 'XXXXXXXX', NULL, 1, 1, 'jose.martinez1990@estu.unan.edu.ni', '00501829fe60d82bec87f3f54d7c4aa3dafef66c36c50eefb606f0ad4df0fb93', '25280043', 0, NULL),
(2, 'Urai', 'Lopez Sanchez', 'La Concepcion Masaya San Caralampio', 1, 'XXX-XXXXXX-XXXXX', 'XXXXXXXX', NULL, 1, 3, 'urai@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', '82808885', 0, NULL),
(3, 'Moises', 'Aguirre', 'La concepcion Masaya San Antonio', 1, 'XXX-XXXXXX-XXXXX', 'XXXXXXXX', NULL, 1, 2, 'Moises.Aguirre1990@estu.unan.edu.ni', '4b4b04529d87b5c318702bc1d7689f70b15ef4fc', '85205459', 0, NULL),
(4, 'Moises', 'Aguirre', 'La concepción Masaya San Antonio Cancha ', 1, 'XXX-XXXXXX-XXXXX', 'XXXXXXXX', NULL, 1, 3, 'Moises.Aguirre1990@estu.unan.edu.ni', '1be3caee2c8ed7251ce8c395fffe98e3f72f8bb8c5b362d1670e2220f05d92ff', '25252525', 0, NULL),
(5, 'Moises', 'Sanchez', 'La Concepcion Masaya San Caralampio', 1, 'XXX-XXXXXX-XXXXX', 'XXXXXXXX', NULL, 0, 2, 'asdfasdfasdf@gmail.com', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '82808885', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion`
--

CREATE TABLE `valoracion` (
  `IdValoracion` int(11) NOT NULL,
  `NombreValoracion` varchar(255) DEFAULT NULL,
  `Puntaje` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoracion`
--

INSERT INTO `valoracion` (`IdValoracion`, `NombreValoracion`, `Puntaje`) VALUES
(1, 'Regular', 2),
(2, 'Buena', 3),
(3, 'Muy buena', 4),
(4, 'Excelente', 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`idActividad`);

--
-- Indices de la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_carpeta` (`id_carpeta`),
  ADD KEY `Idcat` (`IdCategoria`);

--
-- Indices de la tabla `aspectosevaluacion`
--
ALTER TABLE `aspectosevaluacion`
  ADD PRIMARY KEY (`IdAspectosEvaluacion`);

--
-- Indices de la tabla `carpetas`
--
ALTER TABLE `carpetas`
  ADD PRIMARY KEY (`IdCarpeta`),
  ADD KEY `Id_usuario` (`Id_usuario`),
  ADD KEY `IdCategoria` (`IdCategoria`);

--
-- Indices de la tabla `categoriaarchivos`
--
ALTER TABLE `categoriaarchivos`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `detalle_archivos`
--
ALTER TABLE `detalle_archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_archivo` (`id_archivo`),
  ADD KEY `id_carpeta` (`id_carpeta`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `detalle_archivos_ibfk4` (`Idcategoria`);

--
-- Indices de la tabla `docente_grupo`
--
ALTER TABLE `docente_grupo`
  ADD PRIMARY KEY (`IdDocenteGrupo`),
  ADD KEY `Id_Docente` (`Id_Docente`),
  ADD KEY `Id_Grupo` (`Id_Grupo`);

--
-- Indices de la tabla `evaluacionentregas`
--
ALTER TABLE `evaluacionentregas`
  ADD PRIMARY KEY (`IdEvaluacionEntrega`),
  ADD KEY `IdEvaluacion` (`IdEvaluacion`),
  ADD KEY `IdAlumno` (`IdAlumno`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`IdEvaluacion`),
  ADD KEY `IdTipoEvaluacion` (`IdTipoEvaluacion`),
  ADD KEY `IdUnidad` (`IdUnidad`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`IdGenero`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`IdGrupo`);

--
-- Indices de la tabla `horas`
--
ALTER TABLE `horas`
  ADD PRIMARY KEY (`IdHoras`),
  ADD KEY `IdEstudiante` (`IdEstudiante`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`idNotas`),
  ADD KEY `IdEvaluacionEntrega` (`IdEvaluacionEntrega`);

--
-- Indices de la tabla `periodo`
--
ALTER TABLE `periodo`
  ADD PRIMARY KEY (`idperiodo`);

--
-- Indices de la tabla `relacionvas`
--
ALTER TABLE `relacionvas`
  ADD PRIMARY KEY (`IdRelacion`),
  ADD KEY `Idusuarios` (`IdAlumno`),
  ADD KEY `IdAspecto` (`IdAspectoEvaluacion`),
  ADD KEY `IdSupervision` (`IdSupervision`),
  ADD KEY `IdValoracion` (`IdValoracion`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IdRol`);

--
-- Indices de la tabla `supervision`
--
ALTER TABLE `supervision`
  ADD PRIMARY KEY (`IdSupervision`);

--
-- Indices de la tabla `tbl_empresa`
--
ALTER TABLE `tbl_empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `tipoevaluacion`
--
ALTER TABLE `tipoevaluacion`
  ADD PRIMARY KEY (`IdTipoEvaluacion`);

--
-- Indices de la tabla `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`IdUnidad`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Idusuarios`),
  ADD KEY `IdRol` (`IdRol`),
  ADD KEY `IdGenero` (`GeneroId`),
  ADD KEY `IdEmpresa` (`Id_Empresa`);

--
-- Indices de la tabla `valoracion`
--
ALTER TABLE `valoracion`
  ADD PRIMARY KEY (`IdValoracion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `idActividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `archivos`
--
ALTER TABLE `archivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `aspectosevaluacion`
--
ALTER TABLE `aspectosevaluacion`
  MODIFY `IdAspectosEvaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `carpetas`
--
ALTER TABLE `carpetas`
  MODIFY `IdCarpeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categoriaarchivos`
--
ALTER TABLE `categoriaarchivos`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_archivos`
--
ALTER TABLE `detalle_archivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `docente_grupo`
--
ALTER TABLE `docente_grupo`
  MODIFY `IdDocenteGrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `evaluacionentregas`
--
ALTER TABLE `evaluacionentregas`
  MODIFY `IdEvaluacionEntrega` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `IdEvaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `IdGenero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `IdGrupo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `horas`
--
ALTER TABLE `horas`
  MODIFY `IdHoras` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `idNotas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `periodo`
--
ALTER TABLE `periodo`
  MODIFY `idperiodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `relacionvas`
--
ALTER TABLE `relacionvas`
  MODIFY `IdRelacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `IdRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `supervision`
--
ALTER TABLE `supervision`
  MODIFY `IdSupervision` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tbl_empresa`
--
ALTER TABLE `tbl_empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipoevaluacion`
--
ALTER TABLE `tipoevaluacion`
  MODIFY `IdTipoEvaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `unidades`
--
ALTER TABLE `unidades`
  MODIFY `IdUnidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Idusuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `valoracion`
--
ALTER TABLE `valoracion`
  MODIFY `IdValoracion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD CONSTRAINT `Idcat` FOREIGN KEY (`IdCategoria`) REFERENCES `categoriaarchivos` (`IdCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `archivos_ibfk_1` FOREIGN KEY (`id_carpeta`) REFERENCES `carpetas` (`IdCarpeta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `carpetas`
--
ALTER TABLE `carpetas`
  ADD CONSTRAINT `IdCategoria` FOREIGN KEY (`IdCategoria`) REFERENCES `categoriaarchivos` (`IdCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `carpetas` FOREIGN KEY (`Id_usuario`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_archivos`
--
ALTER TABLE `detalle_archivos`
  ADD CONSTRAINT `detalle_archivos_ibfk4` FOREIGN KEY (`Idcategoria`) REFERENCES `categoriaarchivos` (`IdCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `detalle_archivos_ibfk_1` FOREIGN KEY (`id_archivo`) REFERENCES `archivos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_archivos_ibfk_2` FOREIGN KEY (`id_carpeta`) REFERENCES `carpetas` (`IdCarpeta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_archivos_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `docente_grupo`
--
ALTER TABLE `docente_grupo`
  ADD CONSTRAINT `Id_Docente` FOREIGN KEY (`Id_Docente`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Id_Grupo` FOREIGN KEY (`Id_Grupo`) REFERENCES `grupos` (`IdGrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evaluacionentregas`
--
ALTER TABLE `evaluacionentregas`
  ADD CONSTRAINT `IdAlumno` FOREIGN KEY (`IdAlumno`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdEvaluacion` FOREIGN KEY (`IdEvaluacion`) REFERENCES `evaluaciones` (`IdEvaluacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `IdTipoEvaluacion` FOREIGN KEY (`IdTipoEvaluacion`) REFERENCES `tipoevaluacion` (`IdTipoEvaluacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdUnidad` FOREIGN KEY (`IdUnidad`) REFERENCES `unidades` (`IdUnidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `horas`
--
ALTER TABLE `horas`
  ADD CONSTRAINT `IdEstudiante` FOREIGN KEY (`IdEstudiante`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `IdEvaluacionEntrega` FOREIGN KEY (`IdEvaluacionEntrega`) REFERENCES `evaluacionentregas` (`IdEvaluacionEntrega`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `relacionvas`
--
ALTER TABLE `relacionvas`
  ADD CONSTRAINT `IdAspecto` FOREIGN KEY (`IdAspectoEvaluacion`) REFERENCES `aspectosevaluacion` (`IdAspectosEvaluacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdSupervision` FOREIGN KEY (`IdSupervision`) REFERENCES `supervision` (`IdSupervision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdValoracion` FOREIGN KEY (`IdValoracion`) REFERENCES `valoracion` (`IdValoracion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Idusuarios` FOREIGN KEY (`IdAlumno`) REFERENCES `usuarios` (`Idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `IdEmpresa` FOREIGN KEY (`Id_Empresa`) REFERENCES `tbl_empresa` (`id_empresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdGenero` FOREIGN KEY (`GeneroId`) REFERENCES `genero` (`IdGenero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdRol` FOREIGN KEY (`IdRol`) REFERENCES `rol` (`IdRol`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
