/*
  # Remove image_url column from games table

  1. Database Cleanup
    - Remove the unused image_url column from games table
    - This column is no longer needed as we're using local images

  2. Performance Benefits
    - Reduces database query size
    - Eliminates external image URL dependencies
    - Improves loading reliability
*/

-- Remove the image_url column as we're now using local images
ALTER TABLE games DROP COLUMN IF EXISTS image_url;