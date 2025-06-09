/*
  # 创建游戏和卡片数据库表

  1. 新建表
    - `games` 表
      - `id` (uuid, 主键)
      - `name` (text, 游戏名称, 唯一)
      - `category_tag` (text, 分类标签, 唯一)
      - `description` (text, 游戏描述)
      - `features` (jsonb, 游戏特色数组)
      - `players` (text, 适合人数)
      - `duration` (text, 游戏时长)
      - `is_active` (boolean, 是否激活)
      - `created_at` (timestamp, 创建时间)
    
    - `cards` 表
      - `id` (uuid, 主键)
      - `game_id` (uuid, 外键关联games表)
      - `category` (text, 卡片分类)
      - `content` (text, 卡片内容)
      - `is_active` (boolean, 是否激活)
      - `created_at` (timestamp, 创建时间)

  2. 安全设置
    - 为两个表启用行级安全 (RLS)
    - 添加公开读取策略，允许匿名和认证用户读取激活的数据
*/

-- 创建 games 表
CREATE TABLE IF NOT EXISTS games (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  category_tag text NOT NULL UNIQUE,
  description text,
  features jsonb DEFAULT '[]'::jsonb,
  players text,
  duration text,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- 创建 cards 表
CREATE TABLE IF NOT EXISTS cards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  game_id uuid NOT NULL REFERENCES games(id) ON DELETE CASCADE,
  category text NOT NULL,
  content text NOT NULL,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- 启用行级安全
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

-- 创建公开读取策略
CREATE POLICY "Games are publicly readable"
  ON games
  FOR SELECT
  TO anon, authenticated
  USING (is_active = true);

CREATE POLICY "Cards are publicly readable"
  ON cards
  FOR SELECT
  TO anon, authenticated
  USING (is_active = true);

-- 插入游戏数据
INSERT INTO games (name, category_tag, description, features, players, duration) VALUES
(
  '聊天破冰盲盒',
  'drinking-topics',
  '每句话都是命运的🎲 用盲盒话题开启今晚的聊天，打破沉默，快速拉近距离！',
  '["随机话题抽取", "四种辣度等级", "适合聚会破冰"]'::jsonb,
  '2-10人',
  '15-30分钟'
),
(
  '得吃大逃杀',
  'battle-royale',
  '紧张刺激的生存竞技游戏，在酒桌上展开一场智慧与运气的较量！',
  '["策略对战", "淘汰机制", "团队合作"]'::jsonb,
  '4-8人',
  '20-40分钟'
),
(
  '二本吻痕',
  'kiss-marks',
  '浪漫互动游戏，通过有趣的挑战和任务增进彼此了解和亲密度。',
  '["浪漫互动", "情侣专属", "增进感情"]'::jsonb,
  '2-6人',
  '10-25分钟'
),
(
  '派对心理学',
  'party-psychology',
  '通过心理测试和性格分析，深入了解朋友们的内心世界和真实想法。',
  '["心理测试", "性格分析", "深度交流"]'::jsonb,
  '3-8人',
  '15-30分钟'
),
(
  '酒宝急生智',
  'wisdom',
  '考验知识储备和反应速度的智力竞赛，看谁能在酒桌上展现最强大脑！',
  '["知识竞赛", "快速抢答", "智力挑战"]'::jsonb,
  '2-8人',
  '10-20分钟'
),
(
  '满地飘零',
  'man-di-piao-ling',
  '创意表演和即兴发挥的游戏，让每个人都能展现自己的艺术天赋。',
  '["创意表演", "即兴发挥", "艺术展示"]'::jsonb,
  '3-10人',
  '15-35分钟'
),
(
  '酒宝月圆夜',
  'moon-night',
  '经典狼人杀游戏的酒桌版本，在推理和欺骗中寻找真相！',
  '["角色扮演", "逻辑推理", "心理博弈"]'::jsonb,
  '6-12人',
  '30-60分钟'
),
(
  '纯爱大作战',
  'love-battle',
  '甜蜜的恋爱主题游戏，通过各种浪漫挑战增进情侣或朋友间的感情。',
  '["恋爱主题", "甜蜜挑战", "情感升温"]'::jsonb,
  '2-8人',
  '15-30分钟'
),
(
  '德州扑克牌',
  'poker',
  '经典的德州扑克游戏，考验你的牌技、心理素质和运气！',
  '["经典扑克", "策略博弈", "技巧竞技"]'::jsonb,
  '2-9人',
  '20-45分钟'
);