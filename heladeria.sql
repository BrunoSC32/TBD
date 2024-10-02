-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2024 at 12:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `heladeria`
--

-- --------------------------------------------------------

--
-- Table structure for table `asistencia`
--

CREATE TABLE `asistencia` (
  `id_asistencia` int(11) NOT NULL,
  `fecha_asistencia` date NOT NULL,
  `hora_entrada` time NOT NULL,
  `hora_salida` time NOT NULL,
  `estado_asistencia` enum('''Retrasaso''','''A tiempo''','''Falta''') NOT NULL DEFAULT '''A tiempo''',
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nit` varchar(12) DEFAULT '0',
  `email_cliente` varchar(100) DEFAULT NULL,
  `fecha_registro_cliente` date DEFAULT NULL,
  `id_persona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL COMMENT 'sin impuestos',
  `id_item` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_modificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `Rol` char(1) NOT NULL,
  `experiencia_empleado` int(11) DEFAULT 0,
  `fecha_nacimiento` date NOT NULL,
  `id_persona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `helados`
--

CREATE TABLE `helados` (
  `id_helado` int(11) NOT NULL,
  `base_helado` varchar(50) DEFAULT NULL,
  `tamanio` varchar(20) DEFAULT NULL,
  `id_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `helado_sabor`
--

CREATE TABLE `helado_sabor` (
  `id_helado_sabor` int(11) NOT NULL,
  `id_helado` int(11) DEFAULT NULL,
  `id_sabor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id_item` int(11) NOT NULL,
  `nombre` varbinary(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo_item` enum('Ingrediente','Producto','Ambos') NOT NULL DEFAULT 'Ingrediente',
  `imagen_item` varchar(255) DEFAULT NULL,
  `precio_item` float(10,2) NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `unidad_medida` int(11) NOT NULL,
  `id_pais` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mesas`
--

CREATE TABLE `mesas` (
  `id_mesa` int(11) NOT NULL,
  `numero_mesa` int(11) NOT NULL DEFAULT 0 COMMENT 'numero de mesa 0 es para llevar',
  `capacidad_mesa` int(11) NOT NULL,
  `ubicacion_mesa` enum('planta baja','planta alta') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `modificaciones_pedido`
--

CREATE TABLE `modificaciones_pedido` (
  `id_modificacion` int(11) NOT NULL,
  `tipo_de_modificacion` enum('''Aniadir''','''Quitar''') NOT NULL,
  `id_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `pagos_cliente`
--

CREATE TABLE `pagos_cliente` (
  `id_pago` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `monto_pago` float NOT NULL,
  `fecha_pago` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `paises`
--

CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL,
  `nombre_pais` varchar(55) NOT NULL,
  `descripcion_pais` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pedidos_cliente`
--

CREATE TABLE `pedidos_cliente` (
  `id_pedido` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `estado_pedido` tinyint(1) NOT NULL,
  `id_mesa` int(11) NOT NULL DEFAULT 0,
  `id_pago` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `pedidos_proveedor`
--

CREATE TABLE `pedidos_proveedor` (
  `id_pedido_proveedor` int(11) NOT NULL,
  `fecha_pedido_proveedor` date NOT NULL,
  `fecha_recibido_proveedor` date DEFAULT NULL,
  `estado` varchar(50) NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `id_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `personas`
--

CREATE TABLE `personas` (
  `id_persona` int(11) NOT NULL,
  `nombre_persona` varchar(100) NOT NULL,
  `apellido_persona` varchar(100) NOT NULL,
  `carnet` varchar(20) DEFAULT NULL,
  `telefono_persona` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `platos_principales`
--

CREATE TABLE `platos_principales` (
  `id_plato` int(11) NOT NULL,
  `complejidad_plato` enum('simple','elaborado') DEFAULT 'simple',
  `tipo_cocina` enum('''nacional''','''internacional''') NOT NULL,
  `id_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `postres`
--

CREATE TABLE `postres` (
  `id_postre` int(11) NOT NULL,
  `tipo_postre` varchar(50) DEFAULT NULL,
  `tamanio_porciones` int(11) DEFAULT NULL COMMENT 'Cantidad de porciones por postre',
  `gluten_free` bit(1) DEFAULT NULL,
  `id_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(55) NOT NULL,
  `contacto` int(11) NOT NULL,
  `telefono_proveedor` varchar(15) NOT NULL,
  `email_proveedor` varchar(55) NOT NULL,
  `direccion_proveedor` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `fecha_reserva` datetime NOT NULL,
  `estado_reserva` enum('confirmado','cancelada','cumplida') DEFAULT NULL,
  `nombre_reserva` varchar(55) NOT NULL,
  `id_mesa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `sabores`
--

CREATE TABLE `sabores` (
  `id_sabor` int(11) NOT NULL,
  `nombre_sabor` varchar(100) DEFAULT NULL,
  `tipo_sabor` varchar(50) DEFAULT NULL,
  `descripcion_sabor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `salarios`
--

CREATE TABLE `salarios` (
  `id_salario` int(11) NOT NULL,
  `monto_base` float NOT NULL,
  `descuento_salario` float DEFAULT NULL,
  `bonificacion` float DEFAULT NULL,
  `fecha_emision` datetime NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `turnos_empleado`
--

CREATE TABLE `turnos_empleado` (
  `id_turno` int(11) NOT NULL,
  `inicio_turno` time NOT NULL,
  `fin_turno` time NOT NULL,
  `dias_turnos` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `asignacion_turno` date NOT NULL COMMENT 'Fecha en que empieza a cumplir este turno',
  `finalizacion_turno` date NOT NULL COMMENT 'Fecha en que deja de cumplir este turno'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `unidades_medida`
--

CREATE TABLE `unidades_medida` (
  `id_unidad_medida` int(11) NOT NULL,
  `nombre_medida` varchar(35) NOT NULL,
  `descripcion_medida` varchar(255) DEFAULT NULL,
  `abreviatura_medida` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id_asistencia`) USING BTREE,
  ADD KEY `id_trabajador` (`id_empleado`) USING BTREE;

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`) USING BTREE,
  ADD KEY `clientes_personas_FK` (`id_persona`) USING BTREE;

--
-- Indexes for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`) USING BTREE,
  ADD KEY `detalles_pedido_pedidos_cliente_FK` (`id_pedido`) USING BTREE,
  ADD KEY `detalles_pedido_productos_menu_FK` (`id_item`) USING BTREE,
  ADD KEY `id_modificacion` (`id_modificacion`);

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`) USING BTREE,
  ADD KEY `trabajadores_personas_FK` (`id_persona`) USING BTREE;

--
-- Indexes for table `helados`
--
ALTER TABLE `helados`
  ADD PRIMARY KEY (`id_helado`) USING BTREE,
  ADD KEY `id_item` (`id_item`);

--
-- Indexes for table `helado_sabor`
--
ALTER TABLE `helado_sabor`
  ADD PRIMARY KEY (`id_helado_sabor`) USING BTREE,
  ADD KEY `id_helado` (`id_helado`) USING BTREE,
  ADD KEY `id_sabor` (`id_sabor`) USING BTREE;

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `unidad_medida` (`unidad_medida`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_pais` (`id_pais`);

--
-- Indexes for table `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`id_mesa`) USING BTREE;

--
-- Indexes for table `modificaciones_pedido`
--
ALTER TABLE `modificaciones_pedido`
  ADD PRIMARY KEY (`id_modificacion`) USING BTREE,
  ADD KEY `id_item` (`id_item`);

--
-- Indexes for table `pagos_cliente`
--
ALTER TABLE `pagos_cliente`
  ADD PRIMARY KEY (`id_pago`) USING BTREE;

--
-- Indexes for table `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indexes for table `pedidos_cliente`
--
ALTER TABLE `pedidos_cliente`
  ADD PRIMARY KEY (`id_pedido`) USING BTREE,
  ADD KEY `pedidos_cliente_clientes_FK` (`id_cliente`) USING BTREE,
  ADD KEY `pedidos_cliente_trabajadores_FK` (`id_empleado`) USING BTREE,
  ADD KEY `pedidos_cliente_mesas_FK` (`id_mesa`) USING BTREE,
  ADD KEY `pedidos_cliente_Pagos_FK` (`id_pago`) USING BTREE;

--
-- Indexes for table `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  ADD PRIMARY KEY (`id_pedido_proveedor`) USING BTREE,
  ADD KEY `pedidos_proveedor_proveedores_FK` (`id_proveedor`) USING BTREE;

--
-- Indexes for table `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id_persona`) USING BTREE;

--
-- Indexes for table `platos_principales`
--
ALTER TABLE `platos_principales`
  ADD PRIMARY KEY (`id_plato`) USING BTREE,
  ADD KEY `id_item` (`id_item`);

--
-- Indexes for table `postres`
--
ALTER TABLE `postres`
  ADD PRIMARY KEY (`id_postre`),
  ADD KEY `id_item` (`id_item`);

--
-- Indexes for table `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`) USING BTREE;

--
-- Indexes for table `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`) USING BTREE,
  ADD KEY `reservas_mesas_FK` (`id_mesa`) USING BTREE;

--
-- Indexes for table `sabores`
--
ALTER TABLE `sabores`
  ADD PRIMARY KEY (`id_sabor`) USING BTREE;

--
-- Indexes for table `salarios`
--
ALTER TABLE `salarios`
  ADD PRIMARY KEY (`id_salario`) USING BTREE,
  ADD KEY `salario_trabajadores_FK` (`id_empleado`) USING BTREE;

--
-- Indexes for table `turnos_empleado`
--
ALTER TABLE `turnos_empleado`
  ADD PRIMARY KEY (`id_turno`) USING BTREE,
  ADD KEY `turnos_trabajador_trabajadores_FK` (`id_empleado`) USING BTREE;

--
-- Indexes for table `unidades_medida`
--
ALTER TABLE `unidades_medida`
  ADD PRIMARY KEY (`id_unidad_medida`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `helados`
--
ALTER TABLE `helados`
  MODIFY `id_helado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `helado_sabor`
--
ALTER TABLE `helado_sabor`
  MODIFY `id_helado_sabor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mesas`
--
ALTER TABLE `mesas`
  MODIFY `id_mesa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modificaciones_pedido`
--
ALTER TABLE `modificaciones_pedido`
  MODIFY `id_modificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pagos_cliente`
--
ALTER TABLE `pagos_cliente`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedidos_cliente`
--
ALTER TABLE `pedidos_cliente`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  MODIFY `id_pedido_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `platos_principales`
--
ALTER TABLE `platos_principales`
  MODIFY `id_plato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `postres`
--
ALTER TABLE `postres`
  MODIFY `id_postre` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sabores`
--
ALTER TABLE `sabores`
  MODIFY `id_sabor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salarios`
--
ALTER TABLE `salarios`
  MODIFY `id_salario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `turnos_empleado`
--
ALTER TABLE `turnos_empleado`
  MODIFY `id_turno` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Constraints for table `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`);

--
-- Constraints for table `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD CONSTRAINT `detalles_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos_cliente` (`id_pedido`),
  ADD CONSTRAINT `detalles_pedido_ibfk_2` FOREIGN KEY (`id_modificacion`) REFERENCES `modificaciones_pedido` (`id_modificacion`),
  ADD CONSTRAINT `detalles_pedido_ibfk_3` FOREIGN KEY (`id_item`) REFERENCES `items` (`id_item`);

--
-- Constraints for table `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`);

--
-- Constraints for table `helados`
--
ALTER TABLE `helados`
  ADD CONSTRAINT `helados_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `items` (`id_item`);

--
-- Constraints for table `helado_sabor`
--
ALTER TABLE `helado_sabor`
  ADD CONSTRAINT `helado_sabor_ibfk_1` FOREIGN KEY (`id_helado`) REFERENCES `helados` (`id_helado`),
  ADD CONSTRAINT `helado_sabor_ibfk_2` FOREIGN KEY (`id_sabor`) REFERENCES `sabores` (`id_sabor`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`unidad_medida`) REFERENCES `unidades_medida` (`id_unidad_medida`),
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  ADD CONSTRAINT `items_ibfk_3` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`);

--
-- Constraints for table `modificaciones_pedido`
--
ALTER TABLE `modificaciones_pedido`
  ADD CONSTRAINT `modificaciones_pedido_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `items` (`id_item`);

--
-- Constraints for table `pedidos_cliente`
--
ALTER TABLE `pedidos_cliente`
  ADD CONSTRAINT `pedidos_cliente_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  ADD CONSTRAINT `pedidos_cliente_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `pedidos_cliente_ibfk_3` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`),
  ADD CONSTRAINT `pedidos_cliente_ibfk_4` FOREIGN KEY (`id_pago`) REFERENCES `pagos_cliente` (`id_pago`);

--
-- Constraints for table `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  ADD CONSTRAINT `pedidos_proveedor_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Constraints for table `platos_principales`
--
ALTER TABLE `platos_principales`
  ADD CONSTRAINT `platos_principales_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `items` (`id_item`);

--
-- Constraints for table `postres`
--
ALTER TABLE `postres`
  ADD CONSTRAINT `postres_ibfk_1` FOREIGN KEY (`id_item`) REFERENCES `items` (`id_item`);

--
-- Constraints for table `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`);

--
-- Constraints for table `salarios`
--
ALTER TABLE `salarios`
  ADD CONSTRAINT `salarios_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);

--
-- Constraints for table `turnos_empleado`
--
ALTER TABLE `turnos_empleado`
  ADD CONSTRAINT `turnos_empleado_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
