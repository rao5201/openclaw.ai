OpenClaw AI - 数据库与部署配置指南
=====================================

一、Supabase 数据库配置
-----------------------
1. 注册 https://supabase.com（免费）
2. 创建新项目，记录:
   - Project URL (例: https://xxxx.supabase.co)
   - anon public key
   - service_role key（管理后台用）

3. 在 SQL Editor 中依次执行:
   - database/schema.sql（创建表结构）
   - database/seed.sql（填充初始数据）

4. 在 index.html 顶部配置:
   const SUPABASE_URL = '你的Project URL';
   const SUPABASE_ANON_KEY = '你的anon key';


二、部署方式
-----------

方式A: GitHub Pages（仅前端，使用localStorage）
- 将 index.html 放在仓库根目录
- Settings > Pages > Source: main / root
- 网址: https://rao5201.github.io/openclaw.ai/

方式B: Vercel（前端 + API后端）
1. 安装: npm i -g vercel
2. 在项目根目录运行: vercel
3. 添加环境变量:
   - SUPABASE_URL
   - SUPABASE_ANON_KEY
   - SUPABASE_SERVICE_KEY
   - ADMIN_KEY = openclaw2026
4. 重新部署: vercel --prod


三、管理后台
-----------
- 点击导航栏"管理后台"
- 密码: openclaw2026
- 功能: 技能CRUD、广告位管理、表单查看、数据导入导出


四、广告位说明
-------------
- 共18个广告位（6×3网格）
- 价格: 10万元/位/月
- 联系邮箱: rao5201@126.com
- 初始已出租: #5 DeepSeek AI, #11 Kimi Chat, #14 Claude Pro
