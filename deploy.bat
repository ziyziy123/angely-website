@echo off
chcp 65001 >nul
echo ==============================================
echo   Angely 官网 — 一键部署工具
echo ==============================================
echo.
echo 请选择部署平台：
echo   [1] Vercel      (免费, 推荐, 需要登录)
echo   [2] Netlify     (免费, 拖拽部署)
echo   [3] GitHub Pages(免费, 需要 GitHub 账号)
echo   [4] Cloudflare   (免费, 需要 API Token)
echo   [5] 仅本地预览  (Python HTTP Server)
echo   [0] 退出
echo.

set /p CHOICE=输入选项编号:

if "%CHOICE%"=="1" goto :vercel
if "%CHOICE%"=="2" goto :netlify
if "%CHOICE%"=="3" goto :github
if "%CHOICE%"=="4" goto :cloudflare
if "%CHOICE%"=="5" goto :local
if "%CHOICE%"=="0" goto :end

echo 无效选项
pause
goto :end

:vercel
echo.
echo 正在部署到 Vercel...
echo 如果提示登录，请按提示在浏览器中完成授权。
call npx vercel --prod --yes
echo.
echo [OK] Vercel 部署完成！请在终端输出中找到你的网站 URL。
goto :end

:netlify
echo.
echo 正在部署到 Netlify...
echo 如果提示登录，请按提示在浏览器中完成授权。
call npx netlify deploy --prod --dir=.
echo.
echo [OK] Netlify 部署完成！请在终端输出中找到你的网站 URL。
goto :end

:github
echo.
echo === GitHub Pages 部署 ===
echo.
echo 步骤 1/3: 检查 Git 状态...
git status >nul 2>&1
if errorlevel 1 (
  echo [!] 当前目录不是 Git 仓库。请先运行 git init && git add -A && git commit -m "init"
  pause
  goto :end
)

echo 步骤 2/3: 请手动执行以下命令:
echo.
echo   gh repo create angely-website --public --source=. --push
echo   或者:
echo   1. 在 GitHub 上新建仓库: https://github.com/new
echo   2. 仓库名填: angely-website
echo   3. 上传此文件夹内所有文件
echo   4. 进入 Settings ^> Pages ^> Source: main branch ^> Save
echo.
echo 步骤 3/3: 等待 1-2 分钟后访问:
echo   https://YOUR_USERNAME.github.io/angely-website/
echo.
goto :end

:cloudflare
echo.
echo === Cloudflare Pages 部署 ===
echo.
echo 前置条件: 需要获取 Cloudflare API Token
echo 获取地址: https://dash.cloudflare.com/profile/api-tokens
echo.
set /p CF_TOKEN=请输入 Cloudflare API Token (留空跳过):
if "%CF_TOKEN%"=="" (
  echo 已跳过 Cloudflare 部署。
  goto :end
)
echo 正在部署...
call npx wrangler pages deploy . --project-name=angely-website
echo.
echo [OK] Cloudflare 部署完成！
goto :end

:local
echo.
echo 启动本地预览服务器...
echo 访问地址: http://localhost:8080
echo 按 Ctrl+C 停止服务器
python -m http.server 8080
goto :end

:end
echo.
pause
