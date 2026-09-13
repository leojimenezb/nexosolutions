# Build de Producción - NEXO Soluciones

Guía para generar el build de producción con las variables de entorno correctas.

## Sistema de Variables de Entorno en Astro

Astro carga automáticamente las variables de entorno en este orden de prioridad:

1. **`.env.production`** - Variables de producción (cuando ejecutas `npm run build`)
2. **`.env`** - Variables locales (para desarrollo)
3. **`.env.example`** - Variables por defecto (plantilla)

## Archivos de Variables de Entorno

### `.env` (Desarrollo Local)
```bash
# Para desarrollo local
PUBLIC_SITE_URL=http://localhost:4321
PUBLIC_CONTACT_PHONE=5523532259
# ... resto de variables de desarrollo
```

### `.env.production` (Producción)
```bash
# Para producción - ACTUALIZAR ESTOS VALORES
PUBLIC_SITE_URL=https://nexosoluciones.com
PUBLIC_CONTACT_PHONE=tu-numero-real
PUBLIC_CONTACT_EMAIL=tu-email-real
# ... resto de variables reales
```

## Comandos de Build

### 1. Build de Desarrollo (Local)
```bash
# Usa variables de .env
npm run build
```

### 2. Build de Producción
```bash
# Usa automáticamente variables de .env.production
npm run build
```

**Nota**: Astro detecta automáticamente que es un build de producción y cargará `.env.production` si existe.

### 3. Build con Variables Explícitas
```bash
# Pasar variables específicas en el comando
PUBLIC_SITE_URL=https://nexosoluciones.com \
PUBLIC_CONTACT_PHONE=5523532259 \
npm run build
```

### 4. Build con Archivo de Variables Personalizado
```bash
# Crear archivo temporal con variables
cp .env.production .env.local
npm run build
```

## Proceso Completo de Build de Producción

### Paso 1: Configurar Variables de Producción

```bash
# Editar .env.production con tus datos reales
nano .env.production
```

**Variables CRÍTICAS a actualizar:**
```env
PUBLIC_SITE_URL=https://nexosoluciones.com  # Tu dominio real
PUBLIC_CONTACT_PHONE=5523532259             # Tu teléfono real
PUBLIC_CONTACT_EMAIL=contacto@nexosoluciones.com  # Tu email real
PUBLIC_WHATSAPP_NUMBER=525523532259         # Tu WhatsApp real
PUBLIC_COMPANY_ADDRESS=Tu dirección real    # Tu dirección real
```

### Paso 2: Verificar Configuración

```bash
# Verificar que .env.production existe
ls -la .env.production

# Verificar contenido
cat .env.production
```

### Paso 3: Generar Build

```bash
# Opción 1: Build normal (usará .env.production automáticamente)
npm run build

# Opción 2: Build forzando producción
NODE_ENV=production npm run build
```

### Paso 4: Verificar Build Generado

```bash
# Verificar que se creó la carpeta dist
ls -la dist/

# Verificar el index.html generado
cat dist/index.html
```

### Paso 5: Probar Localmente

```bash
# Previsualizar el build de producción
npm run preview

# Acceder a http://localhost:4321
```

## Verificación de Variables en el Build

### Método 1: Inspeccionar HTML Generado

```bash
# Buscar variables en el HTML generado
grep -r "nexosoluciones.com" dist/
grep -r "5523532259" dist/
```

### Método 2: Verificar en el Navegador

1. Inicia `npm run preview`
2. Abre `http://localhost:4321`
3. Inspecciona el código fuente
4. Verifica que las variables sean correctas:
   - URL del sitio
   - Teléfono en enlaces
   - Email en enlaces
   - Meta tags de SEO

## Troubleshooting

### Las variables no se aplican en el build

**Problema**: Astro no está detectando `.env.production`

**Solución**:
```bash
# Asegúrate de que el archivo exista
ls -la .env.production

# Verifica que no tenga errores de sintaxis
cat .env.production

# Recrea el archivo
cp .env.example .env.production
# Edítalo nuevamente
```

### Build usa variables de desarrollo

**Problema**: Está usando `.env` en lugar de `.env.production`

**Solución**:
```bash
# Renombrar temporalmente .env
mv .env .env.dev

# Hacer build
npm run build

# Restaurar .env
mv .env.dev .env
```

### Variables tienen valores incorrectos

**Problema**: Los valores en `.env.production` no son los correctos

**Solución**:
```bash
# Editar directamente
nano .env.production

# O usar un editor diferente
code .env.production
```

## Build para Diferentes Entornos

### Desarrollo
```bash
# Usa .env
npm run build
```

### Staging
```bash
# Crear .env.staging
cp .env.example .env.staging
# Editar con datos de staging
NODE_ENV=staging npm run build
```

### Producción
```bash
# Usa .env.production automáticamente
npm run build
```

## Integración con CI/CD

### GitHub Actions

```yaml
- name: Build
  run: npm run build
  env:
    PUBLIC_SITE_URL: ${{ secrets.SITE_URL }}
    PUBLIC_CONTACT_PHONE: ${{ secrets.CONTACT_PHONE }}
    PUBLIC_CONTACT_EMAIL: ${{ secrets.CONTACT_EMAIL }}
    # ... resto de variables
```

### Docker

Las variables ya están configuradas en `docker-compose.prod.yml`:

```bash
docker-compose -f docker-compose.prod.yml build
```

## Script de Build Automatizado

Crea `scripts/build-prod.sh`:

```bash
#!/bin/bash

echo "🚀 Iniciando build de producción..."

# Verificar que .env.production existe
if [ ! -f .env.production ]; then
    echo "❌ Error: .env.production no existe"
    echo "📝 Creando desde .env.example..."
    cp .env.example .env.production
    echo "⚠️  Por favor edita .env.production con tus datos reales"
    exit 1
fi

# Hacer build
echo "🔨 Generando build..."
npm run build

# Verificar que se creó dist
if [ ! -d "dist" ]; then
    echo "❌ Error: No se generó la carpeta dist"
    exit 1
fi

echo "✅ Build completado exitosamente"
echo "📁 Archivos generados en dist/"
ls -lh dist/
```

Dar permisos:
```bash
chmod +x scripts/build-prod.sh
```

Usar:
```bash
./scripts/build-prod.sh
```

## Resumen de Comandos

```bash
# Desarrollo
npm run dev

# Build normal (desarrollo)
npm run build

# Build de producción (automático si existe .env.production)
npm run build

# Preview del build
npm run preview

# Forzar build de producción
NODE_ENV=production npm run build
```

## Checklist Antes de Desplegar

- [ ] `.env.production` existe y está configurado
- [ ] Variables críticas actualizadas (URL, teléfono, email)
- [ ] Build generado exitosamente
- [ ] Preview local funciona correctamente
- [ ] Variables verificadas en el HTML generado
- [ ] Archivo `.htaccess` incluido en `dist/`
- [ ] No hay errores en consola del navegador

## Recursos

- [Astro Environment Variables](https://docs.astro.build/en/guides/environment-variables/)
- [Astro Deployment](https://docs.astro.build/en/guides/deploy/)