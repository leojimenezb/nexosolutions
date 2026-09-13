# Script simplificado de despliegue a GitHub Pages
Write-Host "🚀 Iniciando despliegue a GitHub Pages..." -ForegroundColor Green

# Paso 1: Generar build
Write-Host "📦 Generando build en Docker..." -ForegroundColor Cyan
docker-compose -f docker-compose.prod.yml exec web sh -c "cd /app; rm -rf dist/; npm run build; cp .htaccess dist/"

# Paso 2: Copiar dist
Write-Host "📋 Copiando dist..." -ForegroundColor Cyan
docker cp nexo-web-prod:/app/dist ./dist-temp

# Paso 3: Crear rama gh-pages
Write-Host "🌿 Creando rama gh-pages..." -ForegroundColor Cyan
git checkout --orphan gh-pages
git rm -rf .

# Paso 4: Copiar archivos
Write-Host "📁 Copiando archivos..." -ForegroundColor Cyan
Copy-Item -Path dist-temp\* -Destination . -Recurse -Force

# Paso 5: Commit
Write-Host "📤 Haciendo commit..." -ForegroundColor Cyan
git add .
git commit -m "Deploy to GitHub Pages"

# Paso 6: Push
Write-Host "🚀 Haciendo push..." -ForegroundColor Cyan
git push origin gh-pages --force

# Paso 7: Volver a main
Write-Host "🔄 Volviendo a main..." -ForegroundColor Cyan
git checkout main

# Paso 8: Limpiar
Write-Host "🧹 Limpiando..." -ForegroundColor Cyan
Remove-Item -Recurse -Force dist-temp

Write-Host "✅ Despliegue completado!" -ForegroundColor Green