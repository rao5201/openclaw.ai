-- ============================================
-- OpenClaw AI 初始数据
-- ============================================

-- 技能市场数据
INSERT INTO skills (name, icon, description, category, installs, sort_order) VALUES
('数据分析师', '📊', 'Excel/CSV文件自动分析，生成可视化图表和洞察报告', '数据', 2840, 1),
('UI设计师', '🎨', '根据描述自动生成UI原型和设计稿，支持多种风格', '设计', 1950, 2),
('邮件管家', '📧', '自动分类、回复邮件，智能摘要和优先级排序', '效率', 3200, 3),
('SEO优化器', '🔍', '网站SEO自动检测和优化建议，关键词分析', '营销', 1680, 4),
('App测试员', '📱', '自动化UI测试，生成测试报告，发现潜在Bug', '开发', 1420, 5),
('财务助理', '💰', '发票OCR识别，自动记账，生成财务报表', '财务', 2100, 6),
('内容创作者', '📝', 'AI辅助写作、排版、SEO优化，支持多语言', '内容', 4500, 7),
('安全巡检', '🛡️', '系统漏洞自动扫描，安全报告生成，实时监控', '安全', 980, 8);

-- 18个广告位 (5, 11, 14 已出租)
INSERT INTO ad_slots (slot_number, status, advertiser_name, contact_email) VALUES
(1, 'available', NULL, NULL),
(2, 'available', NULL, NULL),
(3, 'available', NULL, NULL),
(4, 'available', NULL, NULL),
(5, 'taken', 'DeepSeek AI', 'biz@deepseek.com'),
(6, 'available', NULL, NULL),
(7, 'available', NULL, NULL),
(8, 'available', NULL, NULL),
(9, 'available', NULL, NULL),
(10, 'available', NULL, NULL),
(11, 'taken', 'Kimi Chat', 'ad@moonshot.cn'),
(12, 'available', NULL, NULL),
(13, 'available', NULL, NULL),
(14, 'taken', 'Claude Pro', 'partners@anthropic.com'),
(15, 'available', NULL, NULL),
(16, 'available', NULL, NULL),
(17, 'available', NULL, NULL),
(18, 'available', NULL, NULL);

-- 网站设置
INSERT INTO site_settings (key, value) VALUES
('site_name', 'OpenClaw AI'),
('admin_password', 'openclaw2026'),
('contact_email', 'rao5201@126.com'),
('ad_price', '100000'),
('ad_price_label', '10万元/位/月');
