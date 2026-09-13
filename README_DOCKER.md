# Docker - NEXO Soluciones

Este proyecto está configurado para ejecutarse en contenedores Docker con soporte completo de variables de entorno.

## Estructura de Archivos Docker

- `docker/astro/Dockerfile` - Dockerfile para desarrollo
- `docker/astro/Dockerfile.prod` - Dockerfile optimizado para producción
- `docker-compose.yml` - Configuración de desarrollo
- `docker-compose.prod.yml` - Configuración de producción

## Desarrollo

### Iniciar contenedor de desarrollo

```bash
docker-compose up
```

### Iniciar en modo detached

```bash
docker-compose up -d
```

### Ver logs

```bash
docker-compose logs -f
```

### Detener contenedor

```bash
docker-compose down
```

### Reconstruir contenedor

```bash
docker-compose up --build
```

## Producción

### Iniciar contenedor de producción

```bash
docker-compose -f docker-compose.prod.yml up
```

### Usar Dockerfile de producción

Modifica `docker-compose.prod.yml` para usar el Dockerfile optimizado:

```yaml
build:
  context: .
  dockerfile: docker/astro/Dockerfile.prod
```

## Variables de Entorno en Docker

Las variables de entorno se configuran en `docker-compose.yml` (desarrollo) y `docker-compose.prod.yml` (producción).

### Variables Principales

```yaml
environment:
  # Configuración del sitio
  PUBLIC_SITE_URL: http://localhost:4321
  PUBLIC_SITE_NAME: NEXO Soluciones
  PUBLIC_SITE_TAGLINE: Tecnología que impulsa tu negocio
  
  # Contacto
  PUBLIC_CONTACT_PHONE: 5523532259
  PUBLIC_CONTACT_EMAIL: contacto@nexosoluciones.com
  PUBLIC_WHATSAPP_NUMBER: 525523532259
  
  # Redes sociales
  PUBLIC_FACEBOOK_URL: https://facebook.com/nexosoluciones
  PUBLIC_INSTAGRAM_URL: https://instagram.com/nexosoluciones
  # ... etc
```

## Actualizar Variables en Producción

1. Edita `docker-compose.prod.yml`
2. Actualiza las variables de entorno con los datos reales
3. Reconstruye y reinicia:

```bash
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up --build
```

## Volumenes y Hot Reload

El contenedor de desarrollo tiene configurado hot reload:

```yaml
volumes:
  - .:/app              # Monta el código fuente
  - /app/node_modules   # Evita conflictos con node_modules
```

Cualquier cambio en los archivos se refleja automáticamente en el contenedor.

## Puerto

El contenedor expone el puerto `4321` y está mapeado al host en el mismo puerto:

```yaml
ports:
  - "4321:4321"
```

Accede al sitio en: `http://localhost:4321`

## Troubleshooting

### El contenedor no inicia

```bash
# Ver logs
docker-compose logs

# Reconstruir completamente
docker-compose down
docker-compose up --build
```

### Cambios no se reflejan

```bash
# Reiniciar contenedor
docker-compose restart
```

### Variables de entorno no funcionan

```bash
# Verificar variables en el contenedor
docker-compose exec web env

# Asegúrate de que las variables estén en docker-compose.yml
```

### Puerto ya en uso

Cambia el mapeo de puertos en `docker-compose.yml`:

```yaml
ports:
  - "4322:4321"  # Usa puerto 4322 en el host
```

## Build de Producción

Para crear una imagen optimizada de producción:

```bash
# Build usando Dockerfile.prod
docker build -f docker/astro/Dockerfile.prod -t nexo-soluciones:prod .

# Ejecutar contenedor de producción
docker run -p 4321:4321 \
  -e PUBLIC_SITE_URL=https://nexosoluciones.com \
  -e PUBLIC_CONTACT_PHONE=5523532259 \
  # ... otras variables
  nexo-soluciones:prod
```

## Optimizaciones

### Dockerfile de Producción

- **Multi-stage build**: Separa build y runtime
- **npm ci --only=production**: Solo instala dependencias de producción
- **Archivos optimizados**: Solo copia archivos necesarios
- **Tamaño reducido**: Imagen más pequeña y rápida

### Variables de Entorno

- **Centralizadas**: Todas las configuraciones en un lugar
- **Seguras**: No se exponen en el código
- **Flexibles**: Distintas configuraciones por entorno

## Ventajas de esta Configuración

✅ **Desarrollo consistente**: Mismo entorno en todos los equipos
✅ **Hot reload**: Cambios en tiempo real
✅ **Variables de entorno**: Configuración flexible
✅ **Producción optimizada**: Build específico para producción
✅ **Fácil despliegue**: Un comando para iniciar todo
✅ **Escalable**: Fácil agregar más servicios