//
//  XMovieplayerController.m
//  healthplus1.0
//
//  Created by Zhantu Xie on 14/11/14.
//  Copyright (c) 2014年 healthplus. All rights reserved.
//

#import "XMovieplayerController.h"

@interface XMovieplayerController ()
@property (nonatomic, strong) UIView *movieBackgroundView;
@property (nonatomic, strong) UIView *downbarview;
@property (nonatomic) CGRect bkFrame;
@property (nonatomic, readwrite) BOOL movieFullscreen;
@property (nonatomic, readwrite) BOOL isleft;
@property(strong)UIButton *fullbtn;
@property(strong)UIButton *pause;
@property(strong)UILabel *playtime;

@end

//static const CGFloat downviewmargins = 100.f;
static const CGFloat downbarviewheghit = 34.f;
@implementation XMovieplayerController


-(void)setFrame:(CGRect)frame{
    
}


-(id)initWithFrame:(CGRect)frame{
    if ( (self = [super init]) ) {
        _bkFrame=frame;
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor blackColor];
        [self setControlStyle:MPMovieControlStyleNone];
        
        _movieFullscreen = NO;
        
//        if (!_movieBackgroundView) {
//            _movieBackgroundView = [[UIView alloc] init];
//            _movieBackgroundView.alpha = 0.f;
//            [_movieBackgroundView setBackgroundColor:[UIColor blackColor]];
//        }
        
    }
    return self;
}

-(void)setdownbar{
    if (!_downbarview) {
        _downbarview=[[UIView alloc] init];
        _fullbtn=[[UIButton alloc]init];
        _pause=[[UIButton alloc]init];
        _playtime=[[UILabel alloc]init];
    }

    _downbarview.frame=CGRectMake(0, self.view.frame.size.height-downbarviewheghit, self.view.frame.size.width, downbarviewheghit);
    [_downbarview setBackgroundColor:[UIColor whiteColor]];
    _downbarview.alpha=0.6;
    _downbarview.layer.cornerRadius=5;
    
    _playtime.frame=CGRectMake(0, 0, 80, downbarviewheghit);
    _playtime.textAlignment=NSTextAlignmentCenter;
    _playtime.center= CGPointMake(_downbarview.frame.size.width/2, _downbarview.frame.size.height/2);
    //全屏按钮
    _fullbtn.frame=CGRectMake(_downbarview.frame.size.width-downbarviewheghit, 0, downbarviewheghit, downbarviewheghit);
    [_fullbtn setBackgroundImage:[UIImage imageNamed:@"fullview.png"] forState:UIControlStateNormal];
    
    _pause.frame=CGRectMake(0, 0, downbarviewheghit, downbarviewheghit);
    [_pause setBackgroundImage:[UIImage imageNamed:@"pausebtn.png"] forState:UIControlStateNormal];
    
    [_downbarview addSubview:_fullbtn];
    [_downbarview addSubview:_playtime];
    [_downbarview addSubview:_pause];
    [self.view addSubview:_downbarview];
    self.isfull=NO;
    [_pause addTarget:self action:@selector(pauseplay) forControlEvents:UIControlEventTouchUpInside];
    [_fullbtn addTarget:self action:@selector(fullbtnaction) forControlEvents:UIControlEventTouchUpInside];
}

//暂停图标
-(void)pauseplay{
    MPMoviePlaybackState playtate=super.playbackState;
    if (playtate==MPMoviePlaybackStatePlaying) {
        [_pause setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [super pause];
    }else if (playtate==MPMoviePlaybackStatePaused){
        [_pause setBackgroundImage:[UIImage imageNamed:@"pausebtn.png"] forState:UIControlStateNormal];
        [super play];
    }
}

- (BOOL)isFullscreen {
    return _movieFullscreen;
}

- (void)setContent:(NSString *)content {
    [super setContentURL:[NSURL URLWithString:content]];
}

- (void)fullbtnaction{
    [self.delegate fullbtnaction];
    [self setFullscreen:self.isfull animated:NO];
}


- (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated {
    if (!fullscreen) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        if (!keyWindow) {
            keyWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        }
        [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeLeft animated: NO];
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform = CGAffineTransformMakeRotation(M_PI*(90)/180.0);
            self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            _downbarview.frame=CGRectMake(40, self.view.bounds.size.height-downbarviewheghit, self.view.bounds.size.width-80, downbarviewheghit);
            _playtime.center=CGPointMake(_downbarview.frame.size.width/2, _downbarview.frame.size.height/2);
            _fullbtn.frame=CGRectMake(_downbarview.frame.size.width-downbarviewheghit, 0, downbarviewheghit, downbarviewheghit);
        } completion:^(BOOL finished) {
            [self.delegate setNavigationBarHidden];
            self.isfull=YES;
        }];
    } else {
        [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated: NO];
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.view.transform = CGAffineTransformIdentity;
            self.view.transform = CGAffineTransformMakeRotation(M_PI*2);
            self.view.frame =self.bkFrame;
            _downbarview.frame=CGRectMake(0, self.view.bounds.size.height-downbarviewheghit, self.view.bounds.size.width, downbarviewheghit);
            _playtime.center=CGPointMake(_downbarview.frame.size.width/2, _downbarview.frame.size.height/2);
            _fullbtn.frame=CGRectMake(_downbarview.frame.size.width-downbarviewheghit, 0, downbarviewheghit, downbarviewheghit);
        } completion:^(BOOL finished) {
            [self.delegate setNavigationBarshow];
            self.isfull=NO;
        }];

    }
}

-(void)orientationChanged
{
    if (self.isfull) {
        UIDeviceOrientation orientaiton = [[UIDevice currentDevice] orientation];
        switch (orientaiton) {
            case UIDeviceOrientationPortrait:{
            }
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                break;
            case UIDeviceOrientationLandscapeLeft:{
                if (self.isleft) {
                    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeLeft animated: NO];
                    [UIView animateWithDuration:0.2 animations:^(void) {
                        self.view.transform = CGAffineTransformIdentity;
                        self.view.transform = CGAffineTransformMakeRotation(M_PI*(90)/180.0);
                        self.view.frame= CGRectMake(0, 0, ScreenWidth,ScreenHeight);
                    } completion:^(BOOL finished) {
                        self.isleft=NO;
                    }];
                }
            }
                break;
            case UIDeviceOrientationLandscapeRight:{
                if (!self.isleft) {
                    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated: NO];
                    [UIView animateWithDuration:0.2 animations:^(void) {
                        self.view.transform = CGAffineTransformIdentity;
                        self.view.transform = CGAffineTransformMakeRotation(-M_PI*(90)/180.0);
                        self.view.frame= CGRectMake(0, 0,ScreenWidth,ScreenHeight );
                    } completion:^(BOOL finished) {
                        self.isleft=YES;
                    }];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)play {
    if (self.showdownbar) {
        [self setdownbar];
    }
    [super play];
    //remote file

}

@end
