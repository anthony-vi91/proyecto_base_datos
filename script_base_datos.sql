create schema veterinaria

--   TABLA CLIENTES
CREATE TABLE veterinaria.clientes (
    id_cliente serial PRIMARY KEY,
    nombre VARCHAR(50)NOT NULL,
    tipo_identificacion VARCHAR(10) NOT NULL CHECK (tipo_identificacion IN ('CEDULA', 'RUC', 'PASAPORTE')),
    identificacion VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP,
   UNIQUE (tipo_identificacion, identificacion)
);


--   TABLA MASCOTAS
CREATE TABLE veterinaria.mascotas (
    id_mascota serial PRIMARY KEY,
    id_cliente INT,
    nombre VARCHAR(50) not null,
    especie VARCHAR(30) not null,
    raza VARCHAR(50) not null,
    sexo VARCHAR(10) not null,
    fecha_nacimiento DATE,
    alergias TEXT,
    FOREIGN KEY (id_cliente) REFERENCES veterinaria.clientes(id_cliente),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP
);

--   TABLA CITAS
CREATE TABLE citas (
    id_cita serial PRIMARY KEY,
    id_mascota INT not null,
    fecha_cita DATETIME,
    motivo TEXT not null,
    diagnostico TEXT not null,
    estado VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP,
    FOREIGN KEY (id_mascota) REFERENCES veterinaria.mascotas(id_mascota)
);


--   TABLA PROVEEDORES
CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(150),
    ruc VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
    fecha_actualizado_en TIMESTAMP
);


--   TABLA PRODUCTOS
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    categoria VARCHAR(50),
    precio_venta DECIMAL(10,2),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
    fecha_actualizado_en TIMESTAMP
);


--   TABLA INVENTARIO
CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_proveedor INT,
    stock_actual INT,
    fecha_actualizacion DATE,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
    fecha_actualizado_en TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);


--   TABLA VENTAS
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_venta DATE,
    total DECIMAL(10,2),
    metodo_pago VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
    fecha_actualizado_en TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


--   TABLA DETALLE FACTURA
CREATE TABLE detalle_factura (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
    fecha_actualizado_en TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
