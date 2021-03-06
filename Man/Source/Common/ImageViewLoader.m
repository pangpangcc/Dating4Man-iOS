//
//  ImageViewLoader.m
//  dating
//
//  Created by Max on 16/2/18.
//  Copyright © 2016年 qpidnetwork. All rights reserved.
//

#import "ImageViewLoader.h"
#import "ServerManager.h"

@interface ImageViewLoader ()

@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) UIActivityIndicatorView* loadingView;
@property (nonatomic, retain) NSURLSessionDownloadTask* downloadTask;

@end

@implementation ImageViewLoader
+ (instancetype)loader {
    ImageViewLoader* loader = [[ImageViewLoader alloc] init];
    return loader;
}

- (id)init {
    if( self = [super init] ) {
        self.manager = [[AFHTTPSessionManager manager] initWithBaseURL:nil];
        self.downloadTask = nil;
        self.delegate = nil;
        self.view = nil;
        self.image = nil;
    }
    return self;
}

- (void)stop {
//    NSLog(@"ImageViewLoader::stop( tid : %d, %@, view : %@ )", tid, self, self.view);
    self.delegate = nil;
    self.view = nil;
    self.image = nil;
    [self.downloadTask cancel];
}

- (BOOL)loadImage {
//    NSLog(@"ImageViewLoader::loadImage( tid : %d, %@, view : %@ )", tid, self, self.view);
    if( self.image ) {
        // 直接显示图片
        return [self displayImage:YES];
        
    } else if( self.path && self.path.length > 0 ) {
        // 尝试加在缓存图片
        NSData *data = [NSData dataWithContentsOfFile:self.path];
        self.image = [UIImage imageWithData:data];
        
        if( self.image ) {
            // 直接显示图片
            return [self displayImage:YES];
            
        } else if( self.url && self.url.length > 0 ) {
            // 下载图片
            if( self.downloadTask && self.downloadTask.originalRequest ) {
                // 存在旧的请求
                if( [self.url isEqualToString:[self.downloadTask.originalRequest.URL absoluteString]] ) {
                    // 如果是同一个请求
                    if( self.downloadTask.state == NSURLSessionTaskStateRunning ) {
                        // 并且在进行中
                        return YES;
                    }
                    
                } else {
                    // 取消旧的
                    [self.downloadTask cancel];
                }
            }
            
            NSURL* url = [NSURL URLWithString:self.url];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            
            ServerManager* manger = [ServerManager manager];
            // 假的服务器或者Demo
            if( AppDelegate().demo || manger.item.fake ) {
                NSString *authString = [[[NSString stringWithFormat:@"%@:%@", @"test", @"5179"] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                authString = [NSString stringWithFormat: @"Basic %@", authString];
                [request setValue:authString forHTTPHeaderField:@"Authorization"];
            }

            self.downloadTask = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//                NSLog(@"ImageViewLoader::loadImage( completionHandler[ downloadProgress : %@ ] )", downloadProgress);
        
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL* documentsDirectoryURL = nil;
                if( self.path ) {
                    documentsDirectoryURL = [NSURL fileURLWithPath:self.path];
                }
                return documentsDirectoryURL;
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//                NSLog(@"ImageViewLoader::loadImage( completionHandler[ response : %@ ] )", response);
//                NSLog(@"ImageViewLoader::loadImage( completionHandler[ filePath : %@ ] )", filePath);
//                NSLog(@"ImageViewLoader::loadImage( completionHandler[ error : %@ ] )", error);
                if( [response isKindOfClass:[NSHTTPURLResponse class]] ) {
                    if( error == nil && ((NSHTTPURLResponse* )response).statusCode == 200 ) {
                        // 显示图片
                        NSData *data = [NSData dataWithContentsOfFile:self.path];
                        self.image = [UIImage imageWithData:data];
                        
                        [self displayImage:YES];

                        return;
                    }
                }
                
                [self displayImage:NO];
                
            }];
            
            // 开始下载
            [self.downloadTask resume];
            
        } else {
            // 无url失败
            return NO;
            
        }
        
    } else {
        // 又无图片又无缓存路径失败
        return NO;
    }
    
    return YES;
}

- (BOOL)displayImage:(BOOL)success {
//    NSLog(@"ImageViewLoader::displayImage( tid : %d, %@, success : %d, view : %@ )", tid, self, success, self.view);
    if( success && self.image != nil && self.view && [self.view respondsToSelector:@selector(setImage:)] ) {
        // 下载成功并且能显示图像
        [self.view performSelector:@selector(setImage:) withObject:self.image];
    }
    [self loadImageFinish:success];
    
    return YES;
}

- (void)loadImageFinish:(BOOL)success {
    // 回调
    if( [self.delegate respondsToSelector:@selector(loadImageFinish:success:)] ) {
        [self.delegate loadImageFinish:self success:success];
    }
}
@end
