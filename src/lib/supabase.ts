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

// API 函数
export async function getGames(): Promise<Game[]> {
  const { data, error } = await supabase
    .from('games')
    .select('*')
    .eq('is_active', true)
    .order('created_at', { ascending: true })

  if (error) {
    console.error('Error fetching games:', error)
    throw error
  }

  return data || []
}

export async function getGameCards(categoryTag: string): Promise<Card[]> {
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

  // 然后获取该游戏的所有卡片
  const { data, error } = await supabase
    .from('cards')
    .select('*')
    .eq('game_id', gameData.id)
    .eq('is_active', true)
    .order('created_at', { ascending: true })

  if (error) {
    console.error('Error fetching cards:', error)
    throw error
  }

  return data || []
}

export async function getCardsByCategory(categoryTag: string, category: string): Promise<Card[]> {
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