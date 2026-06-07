# Angely 官网部署指南

## 项目结构
```
angely-website/
├── index.html        # 主页面
├── demo.html         # 在线演示
├── help.html         # 帮助中心
├── privacy.html      # 隐私政策
├── terms.html        # 用户协议
├── common.css        # 全局样式
├── theme.js          # 主题切换
├── favicon.svg       # 网站图标
├── robots.txt        # 爬虫规则
├── sitemap.xml       # 站点地图
└── package.json      # 项目元信息
```

## 部署方式（推荐）

### 方案一：Vercel（免费，推荐）
```bash
npm i -g vercel
cd angely-website
vercel --prod
```

### 方案二：GitHub Pages
```bash
git init && git add -A && git commit -m "Angely v1.0"
git remote add origin https://github.com/YOUR_USER/angely-website.git
git push -u origin main
# 在 GitHub 仓库 Settings → Pages → Source: main branch → Save
```

### 方案三：Cloudflare Pages
```bash
# 在 Cloudflare Dashboard → Workers & Pages → Create → Pages
# 连接 Git 仓库或直接上传文件夹
npx wrangler pages deploy .
```

### 方案四：Netlify
```bash
# 在 Netlify Dashboard → Add new site → Deploy manually
# 直接拖拽 angely-website 文件夹到页面上传区域
```

### 方案五：传统服务器（Nginx）
```nginx
server {
    listen 443 ssl http2;
    server_name angely.app www.angely.app;
    root /var/www/angely-website;
    index index.html;
    location / {
        try_files $uri $uri.html $uri/ =404;
    }
    # SSL cert managed by certbot
}
```

## 部署前检查清单
- [ ] 替换 index.html 中预览图占位 SVG 为实际截图
- [ ] 替换所有下载链接 `#` 为实际 CDN/OSS 链接
- [ ] 替换所有校验码占位为实际文件哈希值
- [ ] 替换联系邮箱为真实邮箱
- [ ] 配置自定义域名 DNS（A/CNAME 记录）
- [ ] 配置 SSL 证书（平台自动或手动）
