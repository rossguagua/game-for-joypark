/*
  # Add image_url column to games table

  1. Changes
    - Add `image_url` column to `games` table
    - Column type: TEXT (nullable)
    - Allows storing image URLs for game cards

  2. Notes
    - This column is nullable to maintain compatibility with existing data
    - Existing games will have NULL image_url values initially
*/

-- Add image_url column to games table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'games' AND column_name = 'image_url'
  ) THEN
    ALTER TABLE games ADD COLUMN image_url text;
  END IF;
END $$;