//
//  XMovieplayerController.h
//  healthplus1.0
//
//  Created by Zhantu Xie on 14/11/14.
//  Copyright (c) 2014年 healthplus. All rights reserved.
//
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#import <MediaPlayer/MediaPlayer.h>
@protocol XMovieplayerControllerDelegate <NSObject>
@optional
-(void)setNavigationBarHidden;
-(void)setNavigationBarshow;
-(void)fullbtnaction;

@end
@interface XMovieplayerController : MPMoviePlayerController

- (void)setFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame;
-(void)orientationChanged;
@property (nonatomic, assign) id<XMovieplayerControllerDelegate> delegate;
@property (nonatomic) BOOL showdownbar;
@property (nonatomic) BOOL isfull;
@end
