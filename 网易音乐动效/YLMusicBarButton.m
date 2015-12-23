//
//  YLMusicBarButton.m
//  网易音乐动效
//
//  Created by 胡晓桥 on 15/12/23.
//  Copyright © 2015年 胡晓桥. All rights reserved.
//

#import "YLMusicBarButton.h"


@interface YLMusicBarButton()
{
    CGFloat width;
    CGFloat height;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *bars;
@property (nonatomic, strong) NSArray *startLengths;
@property (nonatomic, strong) NSArray *endLengths;


@end

@implementation YLMusicBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _contentView = [UIView new];
        width = frame.size.width / 4 / 2;
        height = frame.size.height;
        _contentView.frame = self.bounds;

        [self addSubview:_contentView];
        [self setupBars];

    }
    return self;
}


- (void)setupBars
{
   
    _startLengths = @[@0.6,@0.4,@0.8,@0.2];
    
    _endLengths = @[@0.4,@0.8,@0.2,@0.6];
    
    _bars = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i ++) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor orangeColor].CGColor;
        layer.bounds = CGRectMake(0, 0, width, [_startLengths[i] floatValue]*height);
        layer.anchorPoint = CGPointMake(0, 1);
        layer.position = CGPointMake(width / 2 + 2 * width * i , height);
        
        [_contentView.layer addSublayer:layer];
        
        [_bars addObject:layer];
    }
    
}


- (void)startAnimation
{
    for (CALayer *layer in _bars) {
        
        CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
        keyAni.duration = 1.f;
        keyAni.fillMode = kCAFillModeBackwards;
        keyAni.repeatCount = NSIntegerMax;
        NSValue *value1 = [NSValue valueWithCGRect:layer.bounds];
        NSInteger index = [_bars indexOfObject:layer];
        NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(0, 0, layer.bounds.size.width, height * [_endLengths[index] floatValue])];
        keyAni.values = @[value1,value2,value1];
        [layer addAnimation:keyAni forKey:@"keyAni"];
    }
    
}

- (void)stopAnimation
{
    for (CALayer *layer in _bars) {
        [layer removeAnimationForKey:@"keyAni"];
        NSInteger index = [_bars indexOfObject:layer];
        layer.bounds = CGRectMake(0, 0,width, height * [_startLengths[index] floatValue]);
    }
}


@end
