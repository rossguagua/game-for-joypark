/*
  # Complete Game Library Database Setup

  1. New Tables
    - `games`
      - `id` (uuid, primary key)
      - `name` (text, unique)
      - `category_tag` (text, unique)
      - `description` (text)
      - `features` (jsonb array)
      - `players` (text)
      - `duration` (text)
      - `is_active` (boolean, default true)
      - `created_at` (timestamp)
    
    - `cards`
      - `id` (uuid, primary key)
      - `game_id` (uuid, foreign key to games)
      - `category` (text)
      - `content` (text)
      - `is_active` (boolean, default true)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access to active records only

  3. Data
    - Insert 9 games with complete information
    - Handle conflicts gracefully

  4. Performance
    - Add indexes for optimal query performance
*/

-- Create games table
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

-- Create cards table
CREATE TABLE IF NOT EXISTS cards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  game_id uuid NOT NULL REFERENCES games(id) ON DELETE CASCADE,
  category text NOT NULL,
  content text NOT NULL,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

-- Safely create policies only if they don't exist
DO $$
BEGIN
  -- Check and create Games policy
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE schemaname = 'public' 
    AND tablename = 'games' 
    AND policyname = 'Games are publicly readable'
  ) THEN
    CREATE POLICY "Games are publicly readable"
      ON games
      FOR SELECT
      TO anon, authenticated
      USING (is_active = true);
  END IF;

  -- Check and create Cards policy
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE schemaname = 'public' 
    AND tablename = 'cards' 
    AND policyname = 'Cards are publicly readable'
  ) THEN
    CREATE POLICY "Cards are publicly readable"
      ON cards
      FOR SELECT
      TO anon, authenticated
      USING (is_active = true);
  END IF;
END $$;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_games_category_tag ON games(category_tag);
CREATE INDEX IF NOT EXISTS idx_games_is_active ON games(is_active);
CREATE INDEX IF NOT EXISTS idx_cards_game_id ON cards(game_id);
CREATE INDEX IF NOT EXISTS idx_cards_category ON cards(category);
CREATE INDEX IF NOT EXISTS idx_cards_is_active ON cards(is_active);

-- Insert game data with conflict handling
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
)
ON CONFLICT (category_tag) DO NOTHING;