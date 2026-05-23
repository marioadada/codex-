@echo off
chcp 65001 >nul
echo.
echo ===== ?? 思维碎片工具 - 一键部署到 GitHub =====
echo.
echo 请先确认：
echo 1. 已登录 github.com（浏览器已登录）
echo 2. 知道你的 GitHub 用户名
echo.

set /p GH_USER=请输入你的 GitHub 用户名: 
set REPO_NAME=codex-

echo.
echo 第一步：在 GitHub 上创建仓库...
curl -s -u "%GH_USER%" https://api.github.com/user/repos -d "{\"name\":\"%REPO_NAME%\",\"public\":true}" >nul 2>&1
echo 完成（如果仓库已存在会报错，不影响）

echo.
echo 第二步：推送代码...
cd /d "%~dp0"
git remote add origin https://github.com/%GH_USER%/%REPO_NAME%.git 2>nul
git push -u origin main 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===== ? 部署成功！ =====
    echo.
    echo 你的工具地址：
    echo https://%GH_USER%.github.io/%REPO_NAME%/
    echo.
    echo 打开上面网址，右上角设置里填 API Key 即可使用。
) else (
    echo.
    echo ?? 推送失败，可能需要输入密码。
    echo 请手动执行以下命令（在终端里输密码）：
    echo git push -u origin main
)

pause

