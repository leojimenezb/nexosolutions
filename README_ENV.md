# Variables de Entorno - NEXO Soluciones

Este proyecto utiliza variables de entorno para configurar todos los datos dinámicos del sitio.

## Configuración

1. **Copia el archivo de ejemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edita el archivo `.env` con tus datos reales:**
   - URL del sitio
   - Información de contacto
   - Redes sociales
   - Datos de la empresa

## Variables Disponibles

### Configuración del Sitio
- `PUBLIC_SITE_URL`: URL principal del sitio
- `PUBLIC_SITE_NAME`: Nombre del sitio (ej: "NEXO Soluciones")
- `PUBLIC_SITE_TAGLINE`: Eslogan del sitio
- `PUBLIC_SITE_DESCRIPTION`: Descripción para SEO

### Información de la Empresa
- `PUBLIC_COMPANY_NAME`: Nombre legal de la empresa
- `PUBLIC_COMPANY_ADDRESS`: Dirección física

### Información de Contacto
- `PUBLIC_CONTACT_PHONE`: Teléfono de contacto
- `PUBLIC_CONTACT_EMAIL`: Email de contacto
- `PUBLIC_WHATSAPP_NUMBER`: Número de WhatsApp (con código de país)

### Redes Sociales
- `PUBLIC_FACEBOOK_URL`: URL de Facebook
- `PUBLIC_INSTAGRAM_URL`: URL de Instagram
- `PUBLIC_LINKEDIN_URL`: URL de LinkedIn
- `PUBLIC_TWITTER_URL`: URL de Twitter

### SEO
- `PUBLIC_SITE_KEYWORDS`: Palabras clave para SEO
- `PUBLIC_SITE_AUTHOR`: Autor del sitio

## Uso en el Código

Las variables están disponibles en todos los componentes Astro:

```astro
---
const siteName = import.meta.env.PUBLIC_SITE_NAME;
const contactEmail = import.meta.env.PUBLIC_CONTACT_EMAIL;
---
```

## Importante

- **Nunca commits el archivo `.env`** - ya está en `.gitignore`
- **Solo commit `.env.example`** - como plantilla
- **Usa `PUBLIC_` prefix** para variables que deben estar disponibles en el cliente
- Las variables sin `PUBLIC_` solo están disponibles en el servidor

## Desarrollo vs Producción

### Desarrollo
- Usa `.env` local con datos de prueba
- URL: `http://localhost:4321`

### Producción
- Configura las variables en tu plataforma de hosting
- O usa un archivo `.env.production` con datos reales
- URL: Tu dominio real

## Verificación

Para verificar que las variables funcionan correctamente:

```bash
npm run dev
```

Luego verifica que:
- El logo muestre el nombre correcto
- Los enlaces de contacto funcionen
- Las redes sociales tengan las URLs correctas
- Los meta tags de SEO tengan la información correcta