import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// 数据库类型定义
export interface Game {
  id: string
  name: string
  category_tag: string
  description: string | null
  features: string[] | null
  players: string | null
  duration: string | null
  image_url: string | null
  is_active: boolean
  created_at: string
}

export interface Card {
  id: string
  game_id: string
  category: string
  content: string
  is_active: boolean
  created_at: string
}

// 优化后的API函数 - 只返回核心游戏信息，不包含卡片数据
export async function getGames(): Promise<Game[]> {
  const { data, error } = await supabase
    .from('games')
    .select('id, name, category_tag, description, features, players, duration, image_url, is_active, created_at')
    .eq('is_active', true)
    .order('created_at', { ascending: true })

  if (error) {
    console.error('Error fetching games:', error)
    throw error
  }

  return data || []
}

// 获取指定游戏的卡片ID列表（方案A - 推荐）
export async function getGameCardIds(categoryTag: string, category: string): Promise<string[]> {
  // 首先获取游戏ID
  const { data: gameData, error: gameError } = await supabase
    .from('games')
    .select('id')
    .eq('category_tag', categoryTag)
    .eq('is_active', true)
    .single()

  if (gameError) {
    console.error('Error fetching game:', gameError)
    throw gameError
  }

  if (!gameData) {
    throw new Error(`Game with category_tag "${categoryTag}" not found`)
  }

  // 只获取卡片ID列表，不获取内容
  const { data, error } = await supabase
    .from('cards')
    .select('id')
    .eq('game_id', gameData.id)
    .eq('category', category)
    .eq('is_active', true)

  if (error) {
    console.error('Error fetching card IDs:', error)
    throw error
  }

  return (data || []).map(card => card.id)
}

// 根据卡片ID获取单张卡片内容
export async function getCardById(cardId: string): Promise<Card | null> {
  const { data, error } = await supabase
    .from('cards')
    .select('*')
    .eq('id', cardId)
    .eq('is_active', true)
    .single()

  if (error) {
    console.error('Error fetching card by ID:', error)
    throw error
  }

  return data
}

// 获取随机卡片（方案B - 备选）
export async function getRandomCard(categoryTag: string, category: string, excludeIds: string[] = []): Promise<Card | null> {
  // 首先获取游戏ID
  const { data: gameData, error: gameError } = await supabase
    .from('games')
    .select('id')
    .eq('category_tag', categoryTag)
    .eq('is_active', true)
    .single()

  if (gameError) {
    console.error('Error fetching game:', gameError)
    throw gameError
  }

  if (!gameData) {
    throw new Error(`Game with category_tag "${categoryTag}" not found`)
  }

  // 构建查询，排除已使用的卡片
  let query = supabase
    .from('cards')
    .select('*')
    .eq('game_id', gameData.id)
    .eq('category', category)
    .eq('is_active', true)

  if (excludeIds.length > 0) {
    query = query.not('id', 'in', `(${excludeIds.join(',')})`)
  }

  const { data, error } = await query

  if (error) {
    console.error('Error fetching random card:', error)
    throw error
  }

  if (!data || data.length === 0) {
    return null
  }

  // 在前端随机选择一张卡片
  const randomIndex = Math.floor(Math.random() * data.length)
  return data[randomIndex]
}

// 保持向后兼容的函数（已弃用，建议使用新的优化函数）
export async function getCardsByCategory(categoryTag: string, category: string): Promise<Card[]> {
  console.warn('getCardsByCategory is deprecated. Use getGameCardIds + getCardById for better performance.')
  
  // 首先获取游戏ID
  const { data: gameData, error: gameError } = await supabase
    .from('games')
    .select('id')
    .eq('category_tag', categoryTag)
    .eq('is_active', true)
    .single()

  if (gameError) {
    console.error('Error fetching game:', gameError)
    throw gameError
  }

  if (!gameData) {
    throw new Error(`Game with category_tag "${categoryTag}" not found`)
  }

  // 然后获取该游戏指定分类的卡片
  const { data, error } = await supabase
    .from('cards')
    .select('*')
    .eq('game_id', gameData.id)
    .eq('category', category)
    .eq('is_active', true)
    .order('created_at', { ascending: true })

  if (error) {
    console.error('Error fetching cards by category:', error)
    throw error
  }

  return data || []
}