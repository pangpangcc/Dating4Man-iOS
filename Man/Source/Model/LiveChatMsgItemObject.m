//
//  LiveChatMsgItemObject.m
//  dating
//
//  Created by test on 16/4/21.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//  LiveChat消息item类

#import "LiveChatMsgItemObject.h"

@implementation LiveChatMsgItemObject

/**
 *  初始化
 *
 *  @return this
 */
- (LiveChatMsgItemObject*)init
{
    self = [super init];
    if (nil != self)
    {
        self.msgId = -1;
        self.sendType = LCMessageItem::SendType_Unknow;
        self.fromId = @"";
        self.toId = @"";
        self.inviteId = @"";
        self.createTime = 0;
        self.statusType = LCMessageItem::StatusType_Unprocess;
        self.msgType = LCMessageItem::MT_Unknow;
        self.procResult = [[LiveChatMsgProcResultObject alloc] init];
        self.textMsg = nil;
        self.warningMsg = nil;
        self.systemMsg = nil;
        self.customMsg = nil;
        self.downloadSuccess = NO;
        self.loadingImage = NO;
        self.emotionMsg = nil;
        self.magicIconMsg = nil;
    }
    return self;
}

@end