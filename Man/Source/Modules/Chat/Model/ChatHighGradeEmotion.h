//
//  ChatHighGradeEmotion.h
//  dating
//
//  Created by Max on 16/10/13.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmotionItemObject.h"
#import "LiveChatEmotionItemObject.h"

@interface ChatHighGradeEmotion : NSObject
/**
 价钱提示
 */
@property (nonatomic, readonly) NSString *priceText;

/**
 图片
 */
@property (nonatomic, readonly) UIImage* image;

///**
// 需要播放的图片文件数组
// */
//@property (nonatomic, readonly) NSArray *emotionImageArray;

/**
 基本属性
 */
@property (nonatomic, retain) EmotionItemObject* emotionItemObject;

/**
 播放属性
 */
@property (nonatomic, retain) LiveChatEmotionItemObject* liveChatEmotionItemObject;

@end
