-- ============================================
-- OpenClaw AI 数据库架构
-- Supabase PostgreSQL
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. 技能市场表
CREATE TABLE skills (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(10),
  description TEXT,
  category VARCHAR(50),
  installs INT DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 广告位表 (18个位置)
CREATE TABLE ad_slots (
  id SERIAL PRIMARY KEY,
  slot_number INT UNIQUE NOT NULL CHECK (slot_number BETWEEN 1 AND 18),
  status VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'taken', 'reserved')),
  advertiser_name VARCHAR(100),
  advertiser_link VARCHAR(500),
  price_monthly DECIMAL(12,2) DEFAULT 100000,
  contact_email VARCHAR(200),
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 广告咨询/联系表单
CREATE TABLE contacts (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  company VARCHAR(200),
  contact_name VARCHAR(100),
  phone VARCHAR(30),
  email VARCHAR(200) NOT NULL,
  ad_position VARCHAR(100),
  duration VARCHAR(50),
  message TEXT,
  type VARCHAR(20) DEFAULT 'ad_inquiry' CHECK (type IN ('ad_inquiry', 'newsletter', 'contact')),
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. 访客统计
CREATE TABLE visitor_stats (
  id SERIAL PRIMARY KEY,
  date DATE UNIQUE DEFAULT CURRENT_DATE,
  page_views INT DEFAULT 0,
  unique_visitors INT DEFAULT 0
);

-- 5. 网站设置
CREATE TABLE site_settings (
  key VARCHAR(50) PRIMARY KEY,
  value TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 索引
CREATE INDEX idx_skills_active ON skills(is_active, sort_order);
CREATE INDEX idx_adslots_status ON ad_slots(status);
CREATE INDEX idx_contacts_type ON contacts(type, is_read);
CREATE INDEX idx_contacts_created ON contacts(created_at DESC);
CREATE INDEX idx_visitor_date ON visitor_stats(date DESC);

-- 自动更新 updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER skills_updated BEFORE UPDATE ON skills FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- RLS 安全策略
ALTER TABLE skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE ad_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE visitor_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- 公开读取
CREATE POLICY "Public read skills" ON skills FOR SELECT USING (is_active = true);
CREATE POLICY "Public read ad_slots" ON ad_slots FOR SELECT USING (true);
CREATE POLICY "Public read settings" ON site_settings FOR SELECT USING (true);

-- 公开写入
CREATE POLICY "Public insert contacts" ON contacts FOR INSERT WITH CHECK (true);
CREATE POLICY "Public upsert visitor" ON visitor_stats FOR ALL USING (true) WITH CHECK (true);
