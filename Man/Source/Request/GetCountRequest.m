//
//  GetCountRequest.m
//  dating
//
//  Created by Max on 16/4/25.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//

#import "GetCountRequest.h"

@implementation GetCountRequest


- (instancetype)init{
    if (self = [super init]) {

    }
    
    return self;
}

- (BOOL)sendRequest {
    if( self.manager ) {
        return HTTPREQUEST_INVALIDREQUESTID != [self.manager getCount:^(BOOL success, OtherGetCountItemObject * _Nonnull item, NSString * _Nonnull errnum, NSString * _Nonnull errmsg) {
            BOOL bFlag = NO;
            
            // 没有处理过, 才进入SessionRequestManager处理
            if( !self.isHandleAlready && self.delegate && [self.delegate respondsToSelector:@selector(request:handleRespond:errnum:errmsg:)] ) {
                bFlag = [self.delegate request:self handleRespond:success errnum:errnum errmsg:errmsg];
                self.isHandleAlready = YES;
            }
            
            if( !bFlag ) {
                self.finishHandler(success, item, errnum, errmsg);
            }
            
        }];
    }
    return NO;
}

- (void)callRespond:(BOOL)success errnum:(NSString* _Nullable)errnum errmsg:(NSString* _Nullable)errmsg {
    if( self.finishHandler && !success ) {
        OtherGetCountItemObject* item = [[OtherGetCountItemObject alloc] init];
        self.finishHandler(NO, item, errnum, errmsg);
    }
}

@end