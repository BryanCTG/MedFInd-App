# MedFind App

MedFind es una aplicación móvil desarrollada en Flutter que permite a los usuarios analizar recetas médicas, recibir recomendaciones de medicamentos y gestionar su compra de forma rápida y sencilla.

## 📱 Funcionalidades implementadas

- Registro de usuario (simulado)
- Visualización de interfaz principal
- Conexión a Webhook mediante HTTP
- Recepción de datos en formato JSON desde n8n
- Visualización de medicamentos recomendados

## ⚙️ Tecnologías utilizadas

- Flutter (Frontend móvil)
- n8n (Automatización y backend)
- HTTP (consumo de API)
- JSON (intercambio de datos)

## 🔄 Flujo de la aplicación

1. El usuario interactúa con la app
2. Flutter envía una petición HTTP a n8n
3. n8n procesa la información (simulación de IA)
4. n8n retorna un JSON con medicamentos
5. Flutter muestra los datos en pantalla

## 🚀 Cómo ejecutar el proyecto

1. Clonar el repositorio:
```bash
git clone https://github.com/TU-USUARIO/medfind-app.git
