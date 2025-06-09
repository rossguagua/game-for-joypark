/*
  # 性能优化迁移

  1. 数据库索引优化
    - 为 cards 表的 game_id 字段创建索引
    - 为 cards 表的 category 字段创建索引
    - 为 games 表的 category_tag 字段创建索引

  2. 添加图片URL字段
    - 为 games 表添加 image_url 字段存储封面图片URL

  3. 性能优化
    - 提升查询速度
    - 减少数据传输量
*/

-- 为 cards 表的 game_id 字段创建索引（高优先级性能优化）
CREATE INDEX IF NOT EXISTS idx_cards_game_id ON cards (game_id);

-- 为 cards 表的 category 字段创建索引
CREATE INDEX IF NOT EXISTS idx_cards_category ON cards (category);

-- 为 games 表的 category_tag 字段创建索引
CREATE INDEX IF NOT EXISTS idx_games_category_tag ON games (category_tag);

-- 为 games 表添加 image_url 字段
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'games' AND column_name = 'image_url'
  ) THEN
    ALTER TABLE games ADD COLUMN image_url text;
  END IF;
END $$;

-- 更新现有游戏的图片URL
UPDATE games SET image_url = 'https://images.pexels.com/photos/1267320/pexels-photo-1267320.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'drinking-topics';
UPDATE games SET image_url = 'https://images.pexels.com/photos/163064/play-stone-network-networked-interactive-163064.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'battle-royale';
UPDATE games SET image_url = 'https://images.pexels.com/photos/1024993/pexels-photo-1024993.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'kiss-marks';
UPDATE games SET image_url = 'https://images.pexels.com/photos/355952/pexels-photo-355952.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'party-psychology';
UPDATE games SET image_url = 'https://images.pexels.com/photos/301703/pexels-photo-301703.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'wisdom';
UPDATE games SET image_url = 'https://images.pexels.com/photos/1181406/pexels-photo-1181406.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'man-di-piao-ling';
UPDATE games SET image_url = 'https://images.pexels.com/photos/1040157/pexels-photo-1040157.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'moon-night';
UPDATE games SET image_url = 'https://images.pexels.com/photos/1024993/pexels-photo-1024993.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'love-battle';
UPDATE games SET image_url = 'https://images.pexels.com/photos/1871508/pexels-photo-1871508.jpeg?auto=compress&cs=tinysrgb&w=400' WHERE category_tag = 'poker';