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

-- Crear tabla Especialidad
CREATE TABLE Especialidad (
    ID_Especialidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL
);

-- Crear tabla Medico
CREATE TABLE Medico (
    Codigo_Med VARCHAR(50) PRIMARY KEY,
    ID_Tipo_Empleado INT,
    ID_Horario_Consulta INT,
    ID_Especialidad INT,
    FOREIGN KEY (Codigo_Med) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado),
    FOREIGN KEY (ID_Horario_Consulta) REFERENCES Horario_Consulta(ID_Horario_Consulta),
    FOREIGN KEY (ID_Especialidad) REFERENCES Especialidad(ID_Especialidad)
);

-- Crear tabla Paciente
CREATE TABLE Paciente (
    Codigo_Pac VARCHAR(50) PRIMARY KEY,
    ID_Medico VARCHAR(50),
    FOREIGN KEY (Codigo_Pac) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Medico) REFERENCES Medico(Codigo_Med)
);

-- Crear tabla Diagnostico
CREATE TABLE Diagnostico (
    ID_Diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Pac VARCHAR(50) NOT NULL,
    Diagnostico TEXT NOT NULL,
    FOREIGN KEY (Codigo_Pac) REFERENCES Paciente(Codigo_Pac)
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

-- Crear tabla Historial de Consulta
CREATE TABLE Historial_Consulta (
    ID_Consulta INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Med VARCHAR(50) NOT NULL,
    Codigo_Pac VARCHAR(50) NOT NULL,
    Fecha_Hora DATETIME NOT NULL,
    Duracion TIME NOT NULL,
    Notas TEXT,
    FOREIGN KEY (Codigo_Med) REFERENCES Medico(Codigo_Med),
    FOREIGN KEY (Codigo_Pac) REFERENCES Paciente(Codigo_Pac)
);

-- Crear tabla Alertas de Vacacion
CREATE TABLE Alerta_Vacacion (
    ID_Alerta INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Persona VARCHAR(50) NOT NULL,
    Fecha_Alerta DATE NOT NULL,
    Fecha_Inicio_Vacacion DATE NOT NULL,
    ID_Tipo_Empleado INT NOT NULL,
    FOREIGN KEY (Codigo_Persona) REFERENCES Persona(Codigo_Per),
    FOREIGN KEY (ID_Tipo_Empleado) REFERENCES Tipo_Empleado(ID_Tipo_Empleado)
);

-- Crear tabla Certificacion
CREATE TABLE Certificacion (
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
INSERT INTO Municipio (Nombre) VALUES 
('Municipio A'),
('Municipio B');

-- Insertar datos en la tabla Dirección
INSERT INTO Direccion (Direccion) VALUES 
('Calle 123'),
('Avenida 456');

-- Insertar datos en la tabla Persona para empleados, médicos y pacientes
INSERT INTO Persona (Codigo_Per, Nombre, ID_Direccion, ID_Municipio) VALUES 
('P001', 'Juan Perez', 1, 1), -- Paciente
('P002', 'Ana Gómez', 2, 2),  -- Paciente
('E001', 'Carlos Ruiz', 1, 1), -- Empleado
('E002', 'Maria Lopez', 2, 2), -- Empleado
('M001', 'Laura Sanchez', 1, 1), -- Médico
('M002', 'Pedro Martinez', 2, 2); -- Médico

-- Insertar datos en la tabla Telefono
INSERT INTO Telefono (ID_Persona, Numero_Telefono) VALUES 
('P001', 123456789),
('P002', 987654321),
('E001', 1122334455),
('E002', 5566778899),
('M001', 9988776655),
('M002', 2233445566);

-- Insertar datos en la tabla Tipo_Empleado
INSERT INTO Tipo_Empleado (Nombre) VALUES 
('Doctor'),
('Enfermero');

-- Insertar datos en la tabla Horario_Consulta
INSERT INTO Horario_Consulta (Dia_Semana, Hora_Inicio, Hora_Fin) VALUES 
('Lunes', '08:00:00', '12:00:00'),
('Martes', '14:00:00', '18:00:00');

-- Insertar datos en la tabla Especialidad
INSERT INTO Especialidad (Nombre) VALUES 
('Cardiología'),
('Pediatría');

-- Insertar datos en la tabla Empleado
INSERT INTO Empleado (Codigo_Emp, ID_Tipo_Empleado) VALUES 
('E001', 2),
('E002', 2);

-- Insertar datos en la tabla Medico
INSERT INTO Medico (Codigo_Med, ID_Tipo_Empleado, ID_Horario_Consulta, ID_Especialidad) VALUES 
('M001', 1, 1, 1),
('M002', 1, 2, 2);

-- Insertar datos en la tabla Paciente
INSERT INTO Paciente (Codigo_Pac, ID_Medico) VALUES 
('P001', 'M001'),
('P002', 'M002');

-- Insertar datos en la tabla Diagnostico
INSERT INTO Diagnostico (Codigo_Pac, Diagnostico) VALUES 
('P001', 'Hipertensión'),
('P002', 'Asma');

-- Insertar datos en la tabla Planificado
INSERT INTO Planificado (Estado) VALUES 
('Pendiente'),
('Aprobado');

-- Insertar datos en la tabla Vacacion
INSERT INTO Vacacion (Codigo_Med, Fecha_Inicio, Fecha_Fin, ID_Planificado) VALUES 
('M001', '2024-07-01', '2024-07-15', 1),
('M002', '2024-08-01', '2024-08-15', 2);

-- Insertar datos en la tabla Fecha_Ingreso_Retiro
INSERT INTO Fecha_Ingreso_Retiro (Codigo_Fec, Fecha_Ingreso, Fecha_Retiro) VALUES 
('M001', '2020-01-01', '2023-01-01'),
('M002', '2021-01-01', '2024-01-01');

-- Insertar datos en la tabla Historial_Consulta
INSERT INTO Historial_Consulta (Codigo_Med, Codigo_Pac, Fecha_Hora, Duracion, Notas) VALUES 
('M001', 'P001', '2024-06-01 10:00:00', '00:30:00', 'Control de presión arterial'),
('M002', 'P002', '2024-06-02 11:00:00', '00:20:00', 'Revisión de síntomas de asma');

-- Insertar datos en la tabla Alerta_Vacacion
INSERT INTO Alerta_Vacacion (Codigo_Persona, Fecha_Alerta, Fecha_Inicio_Vacacion, ID_Tipo_Empleado) VALUES 
('P001', '2024-06-01', '2024-07-01', 1),
('P002', '2024-07-01', '2024-08-01', 2);

-- Insertar datos en la tabla Certificacion
INSERT INTO Certificacion (Codigo_Persona, Nombre_Certificacion, Fecha_Obtencion, Fecha_Vencimiento, ID_Tipo_Empleado) VALUES 
('M001', 'Certificado en Cardiología', '2020-01-01', '2025-01-01', 1),
('M002', 'Certificado en Pediatría', '2021-01-01', '2026-01-01', 1);

-- Consultas

-- 1. Listado de pacientes a cargo de un médico de acuerdo con su especialidad

SELECT 
    Paciente.Codigo_Pac AS ID_Paciente,
    Persona.Nombre AS Nombre_Paciente,
    Diagnostico.Diagnostico,
    Especialidad.Nombre AS Especialidad_Medico
FROM 
    Paciente
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
JOIN 
    Medico ON Paciente.ID_Medico = Medico.Codigo_Med
JOIN 
    Diagnostico ON Paciente.Codigo_Pac = Diagnostico.Codigo_Pac
JOIN 
    Especialidad ON Medico.ID_Especialidad = Especialidad.ID_Especialidad
WHERE 
    Especialidad.Nombre = 'Especialidad_Deseada';


-- 2. Listado de médicos que el centro de salud tiene disponibles para alguna especialidad particular

SELECT 
    Medico.Codigo_Med AS ID_Medico,
    Persona.Nombre AS Nombre_Medico,
    Especialidad.Nombre AS Especialidad,
    Horario_Consulta.Dia_Semana,
    Horario_Consulta.Hora_Inicio,
    Horario_Consulta.Hora_Fin
FROM 
    Medico
JOIN 
    Persona ON Medico.Codigo_Med = Persona.Codigo_Per
JOIN 
    Especialidad ON Medico.ID_Especialidad = Especialidad.ID_Especialidad
JOIN 
    Horario_Consulta ON Medico.ID_Horario_Consulta = Horario_Consulta.ID_Horario_Consulta
LEFT JOIN 
    Vacacion ON Medico.Codigo_Med = Vacacion.Codigo_Med
        AND CURDATE() BETWEEN Vacacion.Fecha_Inicio AND Vacacion.Fecha_Fin
WHERE 
    Especialidad.Nombre = 'Especialidad_Deseada'
    AND Vacacion.Codigo_Med IS NULL;



-- 3. Conocer los datos de los pacientes a los cuales se les ha diagnosticado una determinada enfermedad
SELECT 
    Paciente.Codigo_Pac AS ID_Paciente,
    Persona.Nombre AS Nombre_Paciente,
    Diagnostico.Diagnostico
FROM 
    Diagnostico
JOIN 
    Paciente ON Diagnostico.Codigo_Pac = Paciente.Codigo_Pac
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
WHERE 
    Diagnostico.Diagnostico LIKE '%Enfermedad_Deseada%';


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
JOIN 
    Planificado ON Vacacion.ID_Planificado = Planificado.ID_Planificado
WHERE 
    ((Vacacion.Fecha_Inicio BETWEEN 'Fecha_Inicio_Rango_Inicial' AND 'Fecha_Inicio_Rango_Final')
    OR 
    (Vacacion.Fecha_Fin BETWEEN 'Fecha_Fin_Rango_Inicial' AND 'Fecha_Fin_Rango_Final'))
    AND 
    Planificado.Estado = 'Planificado';


-- 5. Historial de Consulta

SELECT 
    Historial_Consulta.ID_Consulta,
    MedicoPersona.Nombre AS Nombre_Medico,
    Paciente.Codigo_Pac AS ID_Paciente,
    PacientePersona.Nombre AS Nombre_Paciente,
    Historial_Consulta.Fecha_Hora,
    Historial_Consulta.Duracion,
    Historial_Consulta.Notas
FROM 
    Historial_Consulta
JOIN 
    Medico ON Historial_Consulta.Codigo_Med = Medico.Codigo_Med
JOIN 
    Persona AS MedicoPersona ON Medico.Codigo_Med = MedicoPersona.Codigo_Per
JOIN 
    Paciente ON Historial_Consulta.Codigo_Pac = Paciente.Codigo_Pac
JOIN 
    Persona AS PacientePersona ON Paciente.Codigo_Pac = PacientePersona.Codigo_Per
WHERE 
    Medico.Codigo_Med = 'Codigo_Medico';

-- 7. Actualización de Contacto / Dirección

-- Actualiza la persona con la nueva dirección
UPDATE Persona, Direccion
SET 
   Direccion = 'Nueva Direccion'
WHERE 
    Codigo_Per = 'Codigo_Persona' and Direccion = "Antigua Direccion";

-- 8. Actualización de Contacto / Teléfono

-- Actualiza el número de teléfono de la persona con el nuevo valor

UPDATE Telefono
SET 
    Numero_Telefono = 'Nuevo_Numero_Telefono'
WHERE 
    ID_Persona = 'Codigo_Persona'
    AND Numero_Telefono = 'Antiguo_Numero_Telefono';

-- 9. Alerta de Vacación

SELECT 
    Alerta_Vacacion.ID_Alerta,
    Persona.Nombre,
    Alerta_Vacacion.Fecha_Alerta,
    Alerta_Vacacion.Fecha_Inicio_Vacacion,
    Alerta_Vacacion.ID_Tipo_Empleado
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
    Diagnostico.Diagnostico
FROM 
    Paciente
JOIN 
    Persona ON Paciente.Codigo_Pac = Persona.Codigo_Per
JOIN 
    Diagnostico ON Paciente.Codigo_Pac = Diagnostico.Codigo_Pac
WHERE 
    Paciente.Codigo_Pac = 'Codigo_Paciente';

-- 11. Capacitación y Certificación

SELECT 
    Certificacion.ID_Certificacion,
    Persona.Nombre AS Nombre_Persona,
    Certificacion.Nombre_Certificacion,
    Certificacion.Fecha_Obtencion,
    Certificacion.Fecha_Vencimiento,
    Certificacion.ID_Tipo_Empleado
FROM 
    Certificacion
JOIN 
    Persona ON Certificacion.Codigo_Persona = Persona.Codigo_Per
WHERE 
    Certificacion.Codigo_Persona = 'Codigo_Persona';
