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
CREATE TABLE veterinaria.citas (
    id_cita SERIAL PRIMARY KEY,
    id_mascota INT NOT NULL,
    fecha_cita TIMESTAMP NOT NULL,
    motivo TEXT NOT NULL,
    diagnostico TEXT NOT NULL,
    estado VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_mascota
        FOREIGN KEY (id_mascota)
        REFERENCES veterinaria.mascotas(id_mascota)
);


--   TABLA PROVEEDORES
CREATE TABLE veterinaria.proveedores (
    id_proveedor serial PRIMARY KEY,
    nombre VARCHAR(100) not null,
    telefono VARCHAR(20) not null,
    email VARCHAR(100) not null,
    direccion VARCHAR(150) not null,
    ruc VARCHAR(20) not null,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP default current_timestamp
);


--   TABLA PRODUCTOS
CREATE TABLE veterinaria.productos (
    id_producto serial PRIMARY KEY,
    nombre VARCHAR(100) not null,
    descripcion TEXT,
    categoria VARCHAR(50),
    precio_venta DECIMAL(10,2) not null,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en timestamp default current_TIMESTAMP
);


--   TABLA INVENTARIO
CREATE TABLE veterinaria.inventario (
    id_inventario serial PRIMARY KEY,
    id_producto INT,
    id_proveedor INT,
    stock_actual INT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP default current_timestamp,
    FOREIGN KEY (id_producto) REFERENCES veterinaria.productos(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES veterinaria.proveedores(id_proveedor)
);


--   TABLA VENTAS
CREATE TABLE veterinaria.ventas (
    id_venta serial PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(20) NOT NULL CHECK (metodo_pago IN ('EFECTIVO', 'DEPOSITO', 'TARJETA')),
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    impuesto DECIMAL(10, 2) DEFAULT 0 CHECK (impuesto >= 0),
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    fecha_actualizado_en TIMESTAMP default current_timestamp,
    FOREIGN KEY (id_cliente) REFERENCES veterinaria.clientes(id_cliente)
);


--   TABLA DETALLE FACTURA
CREATE TABLE veterinaria.detalle_Factura (
    id_detalle SERIAL PRIMARY KEY,
    id_factura INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal_linea DECIMAL(10, 2) NOT NULL CHECK (subtotal_linea >= 0),
   activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   actualizado_en TIMESTAMP,
    FOREIGN KEY (id_factura) REFERENCES veterinaria.ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES veterinaria.productos(id_producto)
);
