//
//  ViewController.m
//  网易音乐动效
//
//  Created by 胡晓桥 on 15/12/23.
//  Copyright © 2015年 胡晓桥. All rights reserved.
//

#import "ViewController.h"
#import "YLMusicBarButton.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define WIDTH (SCREEN_WIDTH / 4)/ 2


@interface ViewController ()
{
    YLMusicBarButton *_musicBarButton;
    BOOL isStop;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _musicBarButton = [[YLMusicBarButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [_musicBarButton addTarget:self action:@selector(didClickBarButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_musicBarButton];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.bounds = CGRectMake(0, 0, 60,30);
    startButton.center = self.view.center;
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(stopBarAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
}

- (void)didClickBarButton
{
    NSLog(@"%s",__FUNCTION__);

}

- (void)stopBarAnimation:(UIButton *)button
{
    if (!isStop) {
        isStop = YES;
        [button setTitle:@"停止" forState:UIControlStateNormal];
        [_musicBarButton startAnimation];
    }else
    {
        isStop = NO;
        [button setTitle:@"开始" forState:UIControlStateNormal];
        [_musicBarButton stopAnimation];
    }
}

@end
