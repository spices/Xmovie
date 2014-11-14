//
//  ViewController.m
//  Xmovie
//
//  Created by Zhantu Xie on 14/11/14.
//  Copyright (c) 2014年 xzt. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) XMovieplayerController *xmoviePlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    self.xmoviePlayer = [[XMovieplayerController alloc] initWithFrame:CGRectMake(50, 50, 100 , 100)];
 
    [self.view addSubview:self.xmoviePlayer.view];
    self.xmoviePlayer.delegate=self;
    [self.xmoviePlayer setContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mp4_remux" ofType:@"mp4"]]];
    self.xmoviePlayer.showdownbar=YES;
}
@end
