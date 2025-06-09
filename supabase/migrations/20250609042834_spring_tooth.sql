/*
  # 插入聊天破冰盲盒游戏的卡片数据

  1. 数据插入
    - 为 drinking-topics 游戏插入所有话题卡片
    - 按照原有的四个分类：surprise, intense, ontheedge, mildmode
    - 保持原有的话题内容不变

  2. 数据结构
    - 每张卡片关联到对应的游戏
    - 设置合适的分类标签
    - 默认激活状态
*/

-- 获取 drinking-topics 游戏的 ID
DO $$
DECLARE
    game_uuid uuid;
BEGIN
    -- 获取游戏ID
    SELECT id INTO game_uuid FROM games WHERE category_tag = 'drinking-topics';
    
    -- 插入 surprise 分类的卡片
    INSERT INTO cards (game_id, category, content) VALUES
    (game_uuid, 'surprise', '如果你能和任何历史人物共进晚餐，你会选谁？'),
    (game_uuid, 'surprise', '分享一个你最近感到特别惊喜或意外的时刻。'),
    (game_uuid, 'surprise', '如果你可以拥有一项超能力，你希望是什么？'),
    (game_uuid, 'surprise', '描述一下你人生中印象最深刻的旅行经历。'),
    (game_uuid, 'surprise', '如果你可以学习任何一项技能，你会选择什么？'),
    (game_uuid, 'surprise', '你有没有一个隐藏的天赋或爱好？'),
    (game_uuid, 'surprise', '你觉得未来十年，世界会有哪些翻天覆地的变化？'),
    (game_uuid, 'surprise', '如果你可以改变自己身上的一件事，会是什么？'),
    (game_uuid, 'surprise', '什么事情让你感到最平静和放松？'),
    (game_uuid, 'surprise', '如果你可以给年轻时的自己一个建议，会是什么？');
    
    -- 插入 intense 分类的卡片
    INSERT INTO cards (game_id, category, content) VALUES
    (game_uuid, 'intense', '你手机相册里最离谱的一张图是？'),
    (game_uuid, 'intense', '说一个你从来没告诉过别人的小癖好。'),
    (game_uuid, 'intense', '有没有一件事你永远不会承认，但其实你做过？'),
    (game_uuid, 'intense', '在你看来，什么是"性张力"？'),
    (game_uuid, 'intense', '你有没有因为"一见钟情"做过什么疯狂的事？'),
    (game_uuid, 'intense', '你的SM属性是什么？'),
    (game_uuid, 'intense', '你最敏感的身体部位是哪里？'),
    (game_uuid, 'intense', '你有没有在公众场合做过什么"脸红心跳"的事情？'),
    (game_uuid, 'intense', '你觉得自己的吻技怎么样？'),
    (game_uuid, 'intense', '如果今晚只能带一个人回家，你会选择谁？'),
    (game_uuid, 'intense', '如果可以亲一个人十秒钟，你会选谁？'),
    (game_uuid, 'intense', '你最近一次被谁"撩"到了？'),
    (game_uuid, 'intense', '如果可以和现场的某个人扮演一天"情侣"，你会选择谁？'),
    (game_uuid, 'intense', '你有没有对在场的某位异性产生过性幻想？敢说是谁吗？'),
    (game_uuid, 'intense', '你认为自己身体哪个部位最具有诱惑力？愿意展示一下吗？'),
    (game_uuid, 'intense', '如果你必须在现场选择一位异性接吻10秒，你会选择谁？'),
    (game_uuid, 'intense', '如果要选择一位异性玩家壁咚5秒钟，你选择谁，你会想对他/她说什么？'),
    (game_uuid, 'intense', '你觉得自己在吸引异性方面，最有效的秘密武器是什么？'),
    (game_uuid, 'intense', '今天的内衣/内裤颜色是什么？'),
    (game_uuid, 'intense', '上一次色色是什么时候？'),
    (game_uuid, 'intense', '上一次买套套是什么时候？');
    
    -- 插入 ontheedge 分类的卡片
    INSERT INTO cards (game_id, category, content) VALUES
    (game_uuid, 'ontheedge', '你最不想让别人看到你什么样子？'),
    (game_uuid, 'ontheedge', '有没有一件你故意不删的聊天记录？'),
    (game_uuid, 'ontheedge', '你觉得什么样的人能成为你的"灵魂伴侣"？'),
    (game_uuid, 'ontheedge', '有没有什么事，你做过但没告诉任何人？'),
    (game_uuid, 'ontheedge', '你最近一次因为什么人或事感到特别心动？'),
    (game_uuid, 'ontheedge', '有没有一句话你一直没敢讲出口？'),
    (game_uuid, 'ontheedge', '你觉得"性"在关系里是第几重要？'),
    (game_uuid, 'ontheedge', '你最容易因为什么被别人吸引？'),
    (game_uuid, 'ontheedge', '在你看来，人生中最值得"投资"的是什么，为什么？'),
    (game_uuid, 'ontheedge', '如果你有一个"人生愿望清单"，你会把什么放在最前面？'),
    (game_uuid, 'ontheedge', '你有没有"偷偷"羡慕甚至嫉妒过身边的人？是因为什么？'),
    (game_uuid, 'ontheedge', '你为了维护自己的利益，做过最"不那么光彩"的事情是什么？'),
    (game_uuid, 'ontheedge', '你认为自己最大的缺点是什么？你试图改变过吗？效果如何？'),
    (game_uuid, 'ontheedge', '如果可以和现场的某个人互换身份一天，你会选择谁，为什么？'),
    (game_uuid, 'ontheedge', '哪种"暧昧举动"最打动你？'),
    (game_uuid, 'ontheedge', '你有没有故意在朋友圈发过"钓鱼内容"？'),
    (game_uuid, 'ontheedge', '如果你出轨了，最可能的理由是？'),
    (game_uuid, 'ontheedge', '你最近一次说谎是什么时候？'),
    (game_uuid, 'ontheedge', '你有过主动删掉一个人吗？'),
    (game_uuid, 'ontheedge', '如果你发现你的伴侣/朋友对你有所隐瞒，你的反应是什么？'),
    (game_uuid, 'ontheedge', '你觉得自己做过最出格的事情是什么？'),
    (game_uuid, 'ontheedge', '如果让你用一种颜色来形容你最近的感情状态，你会选什么颜色？');
    
    -- 插入 mildmode 分类的卡片
    INSERT INTO cards (game_id, category, content) VALUES
    (game_uuid, 'mildmode', '用三个词形容你今天的状态。'),
    (game_uuid, 'mildmode', '如果可以和未来的自己对话，你会问什么？'),
    (game_uuid, 'mildmode', '最喜欢用什么表情包？能现场表演一下吗？'),
    (game_uuid, 'mildmode', '最近一次熬夜，是为了什么？'),
    (game_uuid, 'mildmode', '最近一次让你觉得"哇塞"的经历是什么？'),
    (game_uuid, 'mildmode', '有什么是你小时候特别想做，但现在觉得很庆幸没做的事？'),
    (game_uuid, 'mildmode', '如果你的生活是一部电影，你觉得现在是什么类型？'),
    (game_uuid, 'mildmode', '你觉得人生中最重要的是什么？'),
    (game_uuid, 'mildmode', '如果你有一个"时间胶囊"，你会放什么进去？'),
    (game_uuid, 'mildmode', '如果你是一件物品，你希望自己是什么？'),
    (game_uuid, 'mildmode', '最让你放松的方式是什么？'),
    (game_uuid, 'mildmode', '有没有一部电影或一本书，让你看了之后感觉世界都变美好了？'),
    (game_uuid, 'mildmode', '如果可以和任何一个人共进晚餐，你会选谁？'),
    (game_uuid, 'mildmode', '最近有没有学到什么新技能，哪怕是很小的？'),
    (game_uuid, 'mildmode', '最喜欢的一句人生格言是什么？'),
    (game_uuid, 'mildmode', '如果你有一只宠物，你希望它是什么？'),
    (game_uuid, 'mildmode', '有没有一个地方，是你每次去都会心情愉悦的？'),
    (game_uuid, 'mildmode', '最近有没有做过什么让你很有成就感的小事？'),
    (game_uuid, 'mildmode', '如果给你一天时间完全自由支配，你会怎么度过？'),
    (game_uuid, 'mildmode', '你最喜欢的季节是什么？为什么？'),
    (game_uuid, 'mildmode', '有没有让你特别骄傲的一个习惯？'),
    (game_uuid, 'mildmode', '如果可以拥有一种稀有能力，比如能听懂动物说话，你希望是什么？'),
    (game_uuid, 'mildmode', '最近有没有发现什么有趣的新爱好？'),
    (game_uuid, 'mildmode', '你最近一次因为什么事情大笑？'),
    (game_uuid, 'mildmode', '有没有一件小事，让你觉得自己"原来还挺厉害的"？'),
    (game_uuid, 'mildmode', '最让你感到舒服的颜色是什么？'),
    (game_uuid, 'mildmode', '有没有什么是你一直想尝试但还没尝试的事情？'),
    (game_uuid, 'mildmode', '最近有没有让你感到特别惊喜的小礼物？'),
    (game_uuid, 'mildmode', '如果可以回到过去的一天，你会选择哪一天？'),
    (game_uuid, 'mildmode', '有没有一个你特别想去但还没去过的地方，为什么？');
END $$;