# Despliegue en Hostinger - NEXO Soluciones

Guía completa para publicar tu proyecto Astro en los diferentes servicios de Hostinger.

## Opciones de Despliegue

### 1. Hosting Compartido (cPanel) - **Recomendado para sitios estáticos**

#### Paso 1: Generar Build de Producción

```bash
# Configurar variables de producción
cp .env.example .env.production

# Editar .env.production con tus datos reales
nano .env.production
```

**Variables importantes en `.env.production`:**
```env
PUBLIC_SITE_URL=https://tu-dominio.com
PUBLIC_SITE_NAME=NEXO Soluciones
PUBLIC_CONTACT_PHONE=tu-numero-real
PUBLIC_CONTACT_EMAIL=tu-email-real
PUBLIC_WHATSAPP_NUMBER=tu-whatsapp-real
# ... resto de variables con datos reales
```

#### Paso 2: Build del Proyecto

```bash
npm run build
```

Esto generará la carpeta `dist/` con todos los archivos estáticos.

#### Paso 3: Subir Archivos via cPanel

1. **Accede a cPanel**:
   - Entra a tu panel de Hostinger
   - Ve a "Hosting" → "Manage"
   - Abre "File Manager"

2. **Sube los archivos**:
   - Navega a `public_html/` (o tu subdominio)
   - Sube todo el contenido de la carpeta `dist/`
   - Puedes usar:
     - Arrastrar y soltar desde el File Manager
     - Cliente FTP (FileZilla)
     - SSH (si tienes acceso)

3. **Verificar estructura**:
   ```
   public_html/
   ├── index.html
   ├── _astro/
   │   ├── assets/
   │   └── ...
   └── ...
   ```

#### Paso 4: Configurar Dominio

- Asegúrate de que tu dominio apunte a la carpeta correcta
- Si es subdominio: `subdominio.tu-dominio.com`
- Si es dominio principal: `tu-dominio.com`

### 2. Cloud Hosting / VPS - **Más control y flexibilidad**

#### Opción A: Docker en VPS

1. **Conecta a tu VPS via SSH**:
   ```bash
   ssh usuario@tu-ip-vps
   ```

2. **Instala Docker y Docker Compose**:
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   ```

3. **Clona tu repositorio**:
   ```bash
   git clone tu-repositorio.git
   cd nexosolutions
   ```

4. **Configura variables de producción**:
   ```bash
   cp .env.example .env
   nano .env
   # Edita con tus datos reales
   ```

5. **Inicia con Docker Compose**:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

6. **Configura Nginx como reverse proxy** (opcional pero recomendado):
   ```nginx
   server {
       listen 80;
       server_name tu-dominio.com;
       
       location / {
           proxy_pass http://localhost:4321;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

#### Opción B: Node.js Directo

1. **Instala Node.js en el VPS**:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

2. **Clona y configura el proyecto**:
   ```bash
   git clone tu-repositorio.git
   cd nexosolutions
   npm install
   cp .env.example .env
   nano .env  # Configura variables
   ```

3. **Build y start**:
   ```bash
   npm run build
   npm run preview
   ```

4. **Usa PM2 para gestión de procesos**:
   ```bash
   npm install -g pm2
   pm2 start "npm run preview" --name nexo-soluciones
   pm2 startup
   pm2 save
   ```

### 3. GitHub Actions + Deploy Automático

#### Configura GitHub Actions para despliegue automático:

1. **Crea `.github/workflows/deploy.yml`**:
   ```yaml
   name: Deploy to Hostinger

   on:
     push:
       branches: [ main ]

   jobs:
     deploy:
       runs-on: ubuntu-latest
       
       steps:
       - uses: actions/checkout@v3
       
       - name: Setup Node.js
         uses: actions/setup-node@v3
         with:
           node-version: '22'
           
       - name: Install dependencies
         run: npm ci
         
       - name: Build
         run: npm run build
         env:
           PUBLIC_SITE_URL: ${{ secrets.SITE_URL }}
           PUBLIC_SITE_NAME: ${{ secrets.SITE_NAME }}
           # ... otras variables
           
       - name: Deploy to Hostinger
         uses: easingthemes/ssh-deploy@v4
         with:
           SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
           REMOTE_HOST: ${{ secrets.REMOTE_HOST }}
           REMOTE_USER: ${{ secrets.REMOTE_USER }}
           TARGET: /home/usuario/public_html
           SOURCE: dist/
   ```

2. **Configura Secrets en GitHub**:
   - `SSH_PRIVATE_KEY`: Tu clave SSH de Hostinger
   - `REMOTE_HOST`: Tu dominio o IP
   - `REMOTE_USER`: Usuario de SSH
   - `SITE_URL`, `SITE_NAME`, etc.: Variables de entorno

## Configuración de Variables en Producción

### Variables Críticas para Actualizar

```env
# Dominio real
PUBLIC_SITE_URL=https://nexosoluciones.com

# Contacto real
PUBLIC_CONTACT_PHONE=5523532259
PUBLIC_CONTACT_EMAIL=contacto@nexosoluciones.com
PUBLIC_WHATSAPP_NUMBER=525523532259

# Redes sociales reales
PUBLIC_FACEBOOK_URL=https://facebook.com/tu-pagina-real
PUBLIC_INSTAGRAM_URL=https://instagram.com/tu-perfil-real
PUBLIC_LINKEDIN_URL=https://linkedin.com/company/tu-empresa-real
PUBLIC_TWITTER_URL=https://twitter.com/tu-usuario-real

# Dirección real
PUBLIC_COMPANY_ADDRESS=Tu dirección real, Ciudad, País
```

## SSL/HTTPS

### Para Hosting Compartido

1. **Let's Encrypt en cPanel**:
   - Ve a "SSL/TLS Status"
   - Selecciona tu dominio
   - Haz clic en "Run AutoSSL"

2. **Forzar HTTPS**:
   - Agrega esto al `.htaccess` en `public_html/`:
   ```apache
   RewriteEngine On
   RewriteCond %{HTTPS} off
   RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
   ```

### Para VPS con Nginx

```nginx
server {
    listen 443 ssl http2;
    server_name tu-dominio.com;
    
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    # Resto de configuración
}
```

## Optimizaciones para Producción

### 1. Habilitar Compresión

**.htaccess (Hosting compartido)**:
```apache
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>
```

**Nginx (VPS)**:
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
```

### 2. Caché de Archivos Estáticos

**.htaccess**:
```apache
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
</IfModule>
```

### 3. CDN Opcional

Considera usar Cloudflare para:
- CDN global
- DDoS protection
- SSL gratuito
- Caché inteligente

## Verificación Post-Despliegue

### Checklist de Verificación

- [ ] Sitio carga correctamente en el dominio
- [ ] Todos los enlaces funcionan
- [ ] HTTPS está configurado y funciona
- [ ] Variables de entorno muestran datos correctos
- [ ] Meta tags de SEO están correctos
- [ ] WhatsApp link funciona
- [ ] Enlaces de redes sociales funcionan
- [ ] Mobile responsive funciona
- [ ] Lighthouse score > 90
- [ ] No hay errores en consola del navegador

### Herramientas de Verificación

```bash
# Verificar SEO
curl -I https://tu-dominio.com

# Verificar headers
curl -v https://tu-dominio.com

# Verificar SSL
openssl s_client -connect tu-dominio.com:443
```

## Troubleshooting

### Sitio no carga

1. **Verifica archivos subidos**:
   - Asegúrate que `index.html` esté en `public_html/`
   - Verifica permisos de archivos (755 para carpetas, 644 para archivos)

2. **Verifica .htaccess**:
   - Asegúrate que no haya reglas conflictivas
   - Prueba renombrándolo temporalmente

### Variables de entorno no funcionan

1. **Hosting compartido**:
   - Las variables deben estar en el build time
   - Regenera el build con las variables correctas

2. **VPS/Docker**:
   - Verifica que las variables estén en docker-compose.yml
   - Reinicia el contenedor

### HTTPS no funciona

1. **Verifica certificado SSL**:
   - En cPanel: SSL/TLS Status
   - En VPS: Verifica configuración de Nginx/Apache

2. **Forzar HTTPS**:
   - Agrega reglas de redirección en .htaccess o Nginx

## Monitoreo y Mantenimiento

### Logs

**Hosting compartido**:
- cPanel → Metrics → Errors
- cPanel → Metrics → Raw Access

**VPS**:
```bash
# Docker logs
docker-compose logs -f

# PM2 logs
pm2 logs nexo-soluciones

# Nginx logs
tail -f /var/log/nginx/error.log
```

### Backups

**Configura backups automáticos**:
- Hosting compartido: cPanel → Backup
- VPS: Configura cron jobs para backups

## Costos Estimados Hostinger

- **Hosting Compartido**: $2.99 - $8.99/mes
- **Cloud Hosting**: $9.99 - $29.99/mes  
- **VPS**: $4.99 - $49.99/mes

## Recomendación

**Para empezar**: Hosting Compartido
- Más económico
- Fácil de configurar
- Ideal para sitios estáticos como este

**Para crecimiento**: Cloud Hosting o VPS
- Más recursos
- Mejor rendimiento
- Escalabilidad

## Soporte Hostinger

- **Live Chat**: 24/7
- **Knowledge Base**: docs.hostinger.com
- **Tutoriales**: tutorials.hostinger.com