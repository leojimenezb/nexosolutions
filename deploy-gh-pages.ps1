# Script de despliegue a GitHub Pages usando rama gh-pages
Write-Host "🚀 Desplegando a GitHub Pages usando rama gh-pages..." -ForegroundColor Green
Write-Host ""

# Verificar que estamos en la rama main
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    Write-Host "⚠️  No estás en la rama main. Cambiando a main..." -ForegroundColor Yellow
    git checkout main
}

Write-Host "📦 Paso 1: Generando build en Docker..." -ForegroundColor Cyan
docker-compose -f docker-compose.prod.yml exec web sh -c "cd /app && rm -rf dist/ && npm run build && cp .htaccess dist/"

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error generando el build en Docker" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "📋 Paso 2: Copiando dist del contenedor..." -ForegroundColor Cyan
docker cp nexo-web-prod:/app/dist ./dist-temp

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error copiando dist del contenedor" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🌿 Paso 3: Creando rama gh-pages..." -ForegroundColor Cyan
git checkout --orphan gh-pages

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  La rama gh-pages ya existe, usándola..." -ForegroundColor Yellow
    git checkout gh-pages
    git rm -rf .
} else {
    Write-Host "✅ Rama gh-pages creada" -ForegroundColor Green
}

Write-Host ""
Write-Host "📁 Paso 4: Copiando contenido de dist a la rama gh-pages..." -ForegroundColor Cyan
Copy-Item -Path "dist-temp\*" -Destination "." -Recurse -Force

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error copiando archivos" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "📤 Paso 5: Haciendo commit..." -ForegroundColor Cyan
git add .
git commit -m "Despliegue a GitHub Pages - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  No hay cambios para commitear" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🚀 Paso 6: Push a GitHub..." -ForegroundColor Cyan
git push origin gh-pages --force

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error haciendo push" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🔄 Paso 7: Volviendo a la rama main..." -ForegroundColor Cyan
git checkout main

Write-Host ""
Write-Host "✅ Despliegue completado exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Configura GitHub Pages:" -ForegroundColor Cyan
Write-Host "   1. Ve a tu repositorio en GitHub"
Write-Host "   2. Settings → Pages"
Write-Host "   3. Source: Deploy from a branch"
Write-Host "   4. Branch: gh-pages"
Write-Host "   5. Folder: / (root)"
Write-Host "   6. Save"
Write-Host ""
Write-Host "🎯 Tu sitio estará disponible en: https://tu-usuario.github.io/nexosolutions" -ForegroundColor Green
Write-Host ""
Write-Host "🧹 Limpiando archivos temporales..." -ForegroundColor Cyan
Remove-Item -Recurse -Force dist-temp -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ Proceso completado" -ForegroundColor Green