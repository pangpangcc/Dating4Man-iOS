//
//  LoginManager.h
//  dating
//
//  Created by Max on 16/2/26.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginItemObject.h"
#import "RegisterItemObject.h"
#import "LoginViewController.h"

@class LoginManager;
@protocol LoginManagerDelegate <NSObject>
@optional

/**
 *  登陆回调
 *
 *  @param manager   登陆状态管理器实例
 *  @param success   是否登陆成功
 *  @param loginItem 登陆成功Item
 *  @param strErrno  登陆失败错误码
 *  @param strErrmsg 登陆失败错误提示
 */
- (void)manager:(LoginManager * _Nonnull)manager onLogin:(BOOL)success loginItem:(LoginItemObject * _Nullable)loginItem errnum:(NSString * _Nonnull)errnum errmsg:(NSString * _Nonnull)errmsg;

/**
 *  注销回调
 *
 *  @param manager 登陆状态管理器实例
 *  @param kick  是否主动注销(YES:主动/NO:超时)
 */
- (void)manager:(LoginManager * _Nonnull)manager onLogout:(BOOL)kick;

@end

typedef enum {
    NONE = 0,
    LOGINING,
    LOGINED
} LoginStatus;

@interface LoginManager : NSObject
/**
 *  登陆状态
 */
@property (nonatomic, assign, readonly) LoginStatus status;

/**
 *  用户名
 */
@property (nonatomic, strong, readonly) NSString* _Nullable email;

/**
 *  密码
 */
@property (nonatomic, strong, readonly) NSString* _Nullable password;

/**
 *  上一次输入用户名
 */
@property (nonatomic, strong, readonly) NSString* _Nullable lastInputEmail;

/**
 *  上一次输入密码
 */
@property (nonatomic, strong, readonly) NSString* _Nullable lastInputPassword;

/**
 *  用户信息
 */
@property (nonatomic, strong, readonly) LoginItemObject* _Nullable loginItem;

/**
 *  获取实例
 *
 *  @return 实例
 */
+ (instancetype _Nonnull)manager;

/**
 *  增加监听器
 *
 *  @param delegate 监听器
 */
- (void)addDelegate:(id<LoginManagerDelegate> _Nonnull)delegate;

/**
 *  移除监听器
 *
 *  @param delegate 监听器
 */
- (void)removeDelegate:(id<LoginManagerDelegate> _Nonnull)delegate;

/**
 *  登陆接口
 *
 *  @param user          用户
 *  @param password      密码
 *  @param checkcode     验证码
 *
 *  @return 是否进入登陆中状态
 */
- (LoginStatus)login:(NSString * _Nullable)user password:(NSString * _Nullable)password checkcode:(NSString * _Nullable)checkcode;

/**
 *  注销接口
 *
 *  @param kick 是否主动注销(或者被踢)
 *
 */
- (void)logout:(BOOL)kick;

/**
 *  自动登陆
 *
 *  @return 是否进入登陆中状态
 */
- (BOOL)autoLogin;

@end
