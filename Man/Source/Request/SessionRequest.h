//
//  SessionRequest.h
//  dating
//
//  Created by Max on 16/3/28.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RequestManager.h"
#import "SessionRequestManager.h"

@interface SessionRequest : NSObject

/**
 *  是否已经处理
 */
@property (nonatomic, assign) BOOL isHandleAlready;

/**
 *  接口返回处理器
 */
@property (nonatomic, weak) _Nullable id<SessionRequestDelegate> delegate;

/**
 *  请求管理器
 */
@property (nonatomic, strong) RequestManager* _Nonnull manager;

/**
 *  发送请求
 *
 *  @return YES:成功发起请求/NO:发起请求失败
 */
- (BOOL)sendRequest;

/**
 *  登陆失败, 调用返回
 *
 *  @param errnum 错误码
 *  @param errmsg 错误提示
 */
- (void)callRespond:(BOOL)success errnum:(NSString* _Nullable)errnum errmsg:(NSString* _Nullable)errmsg;

@end
