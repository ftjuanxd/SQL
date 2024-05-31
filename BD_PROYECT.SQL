CREATE DATABASE Hospital;

USE Hospital;

-- Creación de Tablas --

-- Crear tabla Municipio 
CREATE TABLE Municipio (
    ID_Municipio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Dirección
CREATE TABLE Direccion (
    ID_Direccion INT AUTO_INCREMENT PRIMARY KEY,
    Direccion VARCHAR(100) NOT NULL
);

-- Crear tabla Persona
CREATE TABLE Persona (
    Codigo_Per VARCHAR(50) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    ID_Direccion INT,
    ID_Municipio INT,
    FOREIGN KEY (ID_Direccion) REFERENCES Direccion(ID_Direccion),
    FOREIGN KEY (ID_Municipio) REFERENCES Municipio(ID_Municipio)
);

-- Crear tabla Telefono
CREATE TABLE Telefono (
    ID_Telefono INT AUTO_INCREMENT PRIMARY KEY,
    ID_Persona VARCHAR(50) NOT NULL,
    Numero_Telefono BIGINT NOT NULL,
    FOREIGN KEY (ID_Persona) REFERENCES Persona(Codigo_Per)
);

-- Crear tabla Tipo_Empleado
CREATE TABLE Tipo_Empleado (
    ID_Tipo_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- Crear tabla Horario de Consulta
CREATE TABLE Horario_Consulta (
    ID_Horario_Consulta INT AUTO_INCREMENT PRIMARY KEY,
    Dia_Semana VARCHAR(10) NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL
);

-- Crear tabla Empleado
CREATE TABLE Empleado (
    Codigo_Emp VARCHAR(50) PRIMARY KEY,
    ID_Tipo_Empleado INT,
    FOREIGN KEY (Codigo_Emp) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado)
);

-- Crear tabla Medico
CREATE TABLE Medico (
    Codigo_Med VARCHAR(50) PRIMARY KEY,
    ID_Tipo_Empleado INT,
    ID_Horario_Consulta INT,
    Especialidad VARCHAR(60) NOT NULL,
    FOREIGN KEY (Codigo_Med) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado),
    FOREIGN KEY (ID_Horario_Consulta) REFERENCES Horario_Consulta(ID_Horario_Consulta)
);

-- Crear tabla Paciente
CREATE TABLE Paciente (
    Codigo_Pac VARCHAR(50) PRIMARY KEY,
    ID_Medico VARCHAR(50),
    Diagnostico TEXT,
    FOREIGN KEY (Codigo_Pac) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(Codigo_Med)
);

-- Crear tabla Planificado
CREATE TABLE Planificado (
    ID_Planificado INT AUTO_INCREMENT PRIMARY KEY,
    Estado VARCHAR(30) NOT NULL
);

-- Crear tabla Vacacion
CREATE TABLE Vacacion (
    ID_Vacacion INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Med VARCHAR(50) NULL,
    Codigo_Emp VARCHAR(50) NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    ID_Planificado INT,
    FOREIGN KEY (Codigo_Med) REFERENCES Medico(Codigo_Med),
    FOREIGN KEY (Codigo_Emp) REFERENCES Empleado(Codigo_Emp),
    FOREIGN KEY (ID_Planificado) REFERENCES Planificado(ID_Planificado),
    CHECK ((Codigo_Med IS NOT NULL AND Codigo_Emp IS NULL) OR (Codigo_Med IS NULL AND Codigo_Emp IS NOT NULL))
);

-- Crear tabla Fecha Ingreso y Retiro
CREATE TABLE Fecha_Ingreso_Retiro (
    ID_Fecha INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Fec VARCHAR(50),
    Fecha_Ingreso DATE NOT NULL,
    Fecha_Retiro DATE NOT NULL,
    FOREIGN KEY (Codigo_Fec) REFERENCES Medico(Codigo_Med)
);

-- Crear tabla Historial de Consultas
CREATE TABLE Historial_Consultas (
    ID_Consulta INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Med VARCHAR(50) NOT NULL,
    Codigo_Pac VARCHAR(50) NOT NULL,
    Fecha_Hora DATETIME NOT NULL,
    Duracion TIME NOT NULL,
    Notas TEXT,
    FOREIGN KEY (Codigo_Med) REFERENCES Medico(Codigo_Med),
    FOREIGN KEY (Codigo_Pac) REFERENCES Paciente(Codigo_Pac)
);

-- Crear tabla Alertas de Vacaciones
CREATE TABLE Alertas_Vacaciones (
    ID_Alerta INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Persona VARCHAR(50) NOT NULL,
    Fecha_Alerta DATE NOT NULL,
    Fecha_Inicio_Vacaciones DATE NOT NULL,
    ID_Tipo_Empleado INT NOT NULL,
    FOREIGN KEY (Codigo_Persona) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado)
);

-- Crear tabla Certificaciones
CREATE TABLE Certificaciones (
    ID_Certificacion INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Persona VARCHAR(50) NOT NULL,
    Nombre_Certificacion VARCHAR(100) NOT NULL,
    Fecha_Obtencion DATE NOT NULL,
    Fecha_Vencimiento DATE,
    ID_Tipo_Empleado INT NOT NULL,
    FOREIGN KEY (Codigo_Persona) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado)
);

-- Insertar Datos En Tablas Básicas

-- Insertar datos en la tabla Municipio
INSERT INTO Municipio (Nombre) VALUES ('Bogotá'), ('Medellín'), ('Cali');

-- Insertar datos en la tabla Dirección
INSERT INTO Direccion (Direccion) VALUES ('Calle 123 #45-67'), ('Avenida 456 #89-10'), ('Carrera 789 #12-34');

-- Insertar datos en la tabla Persona
INSERT INTO Persona (Codigo_Per, Nombre, ID_Direccion, ID_Municipio) 
VALUES 
('P001', 'Juan Perez', 1, 1),
('P002', 'Maria Rodriguez', 2, 2),
('P003', 'Carlos Gomez', 3, 3);

-- Insertar datos en la tabla Telefono
INSERT INTO Telefono (ID_Persona, Numero_Telefono)
VALUES 
('P001', 3001234567),
('P002', 3109876543),
('P003', 3201928374);

-- Insertar datos en la tabla Tipo_Empleado
INSERT INTO Tipo_Empleado (Nombre) VALUES ('Auxiliar de Enfermería'), ('Vigilante'), ('Médico');

-- Insertar Datos en Tablas Dependientes

-- Insertar datos en la tabla Horario_Consulta
INSERT INTO Horario_Consulta (Dia_Semana, Hora_Inicio, Hora_Fin)
VALUES 
('Lunes', '08:00:00', '12:00:00'),
('Martes', '13:00:00', '17:00:00');

-- Insertar datos en la tabla Empleado
INSERT INTO Empleado (Codigo_Emp, ID_Tipo_Empleado) 
VALUES 
('P002', 1),  -- Maria Rodriguez como Auxiliar de Enfermería
('P003', 2);  -- Carlos Gomez como Vigilante

-- Insertar datos en la tabla Medico
INSERT INTO Medico (Codigo_Med, ID_Tipo_Empleado, ID_Horario_Consulta, Especialidad)
VALUES 
('P001', 3, 1, 'Cardiología');  -- Juan Perez como Médico Cardiología

-- Insertar datos en la tabla Paciente
INSERT INTO Paciente (Codigo_Pac, ID_Medico, Diagnostico)
VALUES 
('P002', 'P001', 'Hipertensión');  -- Maria Rodriguez atendida por Juan Perez

-- Insertar Datos en Tablas Complejas

-- Insertar datos en la tabla Planificado
INSERT INTO Planificado (Estado)
VALUES 
('Planificado'), 
('En Progreso'), 
('Completado');

-- Insertar datos en la tabla Vacacion
INSERT INTO Vacacion (Codigo_Med, Codigo_Emp, Fecha_Inicio, Fecha_Fin, ID_Planificado)
VALUES 
('P001', NULL, '2024-07-01', '2024-07-15', 1),  -- Vacación para Juan Perez
(NULL, 'P002', '2024-06-01', '2024-06-15', 2);  -- Vacación para Maria Rodriguez

-- Insertar datos en la tabla Fecha_Ingreso_Retiro
INSERT INTO Fecha_Ingreso_Retiro (Codigo_Fec, Fecha_Ingreso, Fecha_Retiro)
VALUES 
('P001', '2024-01-01', '2024-05-31');  -- Juan Perez trabajando de Enero a Mayo 2024

-- Insertar datos en la tabla Historial_Consultas
INSERT INTO Historial_Consultas (Codigo_Med, Codigo_Pac, Fecha_Hora, Duracion, Notas)
VALUES 
('P001', 'P002', '2024-04-01 10:00:00', '00:30:00', 'Consulta de seguimiento de hipertensión');  -- Consulta entre Juan Perez y Maria Rodriguez

-- Insertar datos en la tabla Alertas_Vacaciones
INSERT INTO Alertas_Vacaciones (Codigo_Persona, Fecha_Alerta, Fecha_Inicio_Vacaciones, ID_Tipo_Empleado)
VALUES 
('P001', '2024-06-01', '2024-07-01', 3),  -- Alerta para Juan Perez sobre sus vacaciones
('P002', '2024-05-01', '2024-06-01', 1);  -- Alerta para Maria Rodriguez sobre sus vacaciones

-- Insertar datos en la tabla Certificaciones
INSERT INTO Certificaciones (Codigo_Persona, Nombre_Certificacion, Fecha_Obtencion, Fecha_Vencimiento, ID_Tipo_Empleado)
VALUES 
('P001', 'Certificación en Cardiología', '2023-12-01', '2026-12-01', 3),  -- Certificación de Juan Perez
('P002', 'Curso de Auxiliar de Enfermería', '2022-05-01', NULL, 1);  -- Certificación de Maria Rodriguez

-- Consultas

-- 1. Listado de pacientes a cargo de un médico de acuerdo con su especialidad

SELECT 
    Paciente.Codigo_Pac AS ID_Paciente,
    Persona.Nombre AS Nombre_Paciente,
    Paciente.Diagnostico,
    Medico.Especialidad
FROM 
    Paciente
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
JOIN 
    Medico ON Paciente.ID_Medico = Medico.Codigo_Med
WHERE 
    Medico.Especialidad = 'Especialidad_Deseada';

-- 2. Listado de médicos que el centro de salud tiene disponibles para alguna especialidad particular

SELECT 
    Medico.Codigo_Med AS ID_Medico,
    Persona.Nombre AS Nombre_Medico,
    Medico.Especialidad
FROM 
    Medico
JOIN 
    Persona ON Medico.Codigo_Med = Persona.Codigo_Per
WHERE 
    Medico.Especialidad = 'Especialidad_Deseada';

-- 3. Conocer los datos de los pacientes a los cuales se les ha diagnosticado una determinada enfermedad

SELECT 
    Paciente.Codigo_Pac AS ID_Paciente,
    Persona.Nombre AS Nombre_Paciente,,
    Paciente.Diagnostico
FROM 
    Paciente
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
WHERE 
    Paciente.Diagnostico LIKE '%Enfermedad_Deseada%';

-- 4. Listado de los médicos que han disfrutado o tienen planeadas las vacaciones en un intervalo de tiempo dado

SELECT 
    Medico.Codigo_Med AS ID_Medico,
    Persona.Nombre AS Nombre_Medico,
    Vacacion.Fecha_Inicio,
    Vacacion.Fecha_Fin
FROM 
    Vacacion
JOIN 
    Medico ON Vacacion.Codigo_Med = Medico.Codigo_Med
JOIN 
    Persona ON Medico.Codigo_Med = Persona.Codigo_Per
WHERE 
    (Vacacion.Fecha_Inicio BETWEEN 'Fecha_Inicio_Rango_Inicial' AND 'Fecha_Inicio_Rango_Final')
    OR 
    (Vacacion.Fecha_Fin BETWEEN 'Fecha_Fin_Rango_Inicial' AND 'Fecha_Fin_Rango_Final');

-- 5. Historial de Consulta

SELECT 
    Historial_Consulta.ID_Consulta,
    Persona.Nombre AS Nombre_Medico,
    Paciente.Codigo_Pac AS ID_Paciente,
    Paciente.Nombre AS Nombre_Paciente,
    Historial_Consulta.Fecha_Hora,
    Historial_Consulta.Duracion,
    Historial_Consulta.Nota
FROM 
    Historial_Consulta
JOIN 
    Medico ON Historial_Consulta.Codigo_Med = Medico.Codigo_Med
JOIN 
    Persona ON Medico.Codigo_Med = Persona.Codigo_Per
JOIN 
    Paciente ON Historial_Consulta.Codigo_Pac = Paciente.Codigo_Pac
WHERE 
    Medico.Codigo_Med = 'Codigo_Medico';

-- 6. Asignación de Pacientes

SELECT 
    Medico.Codigo_Med AS ID_Medico,
    Persona.Nombre AS Nombre_Medico,
    Medico.Especialidad,
    Horario_Consulta.Dia_Semana,
    Horario_Consulta.Hora_Inicio,
    Horario_Consulta.Hora_Fin
FROM 
    Medico
JOIN 
    Persona ON Medico.Codigo_Med = Persona.Codigo_Per
JOIN 
    Horario_Consulta ON Medico.ID_Horario_Consulta = Horario_Consulta.ID_Horario_Consulta
WHERE 
    Medico.Especialidad = 'Especialidad_Deseada';

-- 7. Actualización de Contacto / Dirección

UPDATE Persona
SET 
    ID_Direccion = 'Nueva_ID_Direccion'
WHERE 
    Codigo_Per = 'Codigo_Persona';

-- 8. Actualización de Contacto / Teléfono

UPDATE Telefono
SET 
    Numero_Telefono = 'Nuevo_Numero_Telefono'
WHERE 
    ID_Persona = 'Codigo_Persona' 
    AND ID_Telefono = 'ID_Telefono';

-- 9. Alerta de Vacación

SELECT 
    Alerta_Vacacion.ID_Alerta,
    Persona.Nombre,
    Alerta_Vacacion.Fecha_Alerta,
    Alerta_Vacacion.Fecha_Inicio_Vacacion,
    Alerta_Vacacion.Persona_Tipo
FROM 
    Alerta_Vacacion
JOIN 
    Persona ON Alerta_Vacacion.Codigo_Persona = Persona.Codigo_Per
WHERE 
    Alerta_Vacacion.Fecha_Alerta BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH);

-- 10. Seguimiento de Diagnósticos

SELECT 
    Paciente.Codigo_Pac AS ID_Paciente,
    Persona.Nombre AS Nombre_Paciente,
    Paciente.Diagnostico
FROM 
    Paciente
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
WHERE 
    Paciente.Codigo_Pac = 'Codigo_Paciente';

-- 11. Capacitación y Certificación

SELECT 
    Certificacion.ID_Certificacion,
    Persona.Nombre,
    Certificacion.Nombre_Certificacion,
    Certificacion.Fecha_Obtencion,
    Certificacion.Fecha_Vencimiento,
    Certificacion.Persona_Tipo
FROM 
    Certificacion
JOIN 
    Persona ON Certificacion.Codigo_Persona = Persona.Codigo_Per
WHERE 
    Certificacion.Codigo_Persona = 'Codigo_Persona';
