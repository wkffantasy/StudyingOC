//
//  RockerView.m
//  Ovis
//
//  Created by wangkongfei on 2019/5/9.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import "RockerView.h"

#define circleWH  45
#define imageWH   150
#define timeCallBack 0.5

//圈外
//-4 是因为图片的问题，
#define maxMoveDistance  (imageWH/2 - circleWH/2 - 4)

//math
#define pi 3.14159265358979323846
#define degreesToRadian(x) (pi * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / pi)

@interface RockerView ()

@property (weak, nonatomic) UIImageView * circleView;
@property (weak, nonatomic) UIImageView * borderImageView;

@property (assign, nonatomic) CGPoint beganPoint;

@property (assign, nonatomic) int backAngel;
@property (assign, nonatomic) int backVelocity;
@property (strong, nonatomic) NSTimer * timer;

@end

@implementation RockerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}
- (void)dealloc {
    [self removeTimer];
}


- (void)setupViews {
    
    UIImageView * backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"icon_rockerImage1"];
    backImageView.backgroundColor = [UIColor clearColor];
    backImageView.layer.masksToBounds = YES;
    backImageView.layer.cornerRadius = imageWH / 2;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.and.height.mas_equalTo(imageWH);
    }];
    
//    UIImageView * borderImageView = [[UIImageView alloc]init];
//    borderImageView.image = [UIImage imageNamed:@"icon_rocker_centerImageBorder"];
//    borderImageView.layer.cornerRadius = circleWH / 2;
//    borderImageView.backgroundColor = [UIColor clearColor];
//    borderImageView.hidden = YES;
//    _borderImageView = borderImageView;
//    [self addSubview:borderImageView];
//    [borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.centerY.mas_equalTo(self.mas_centerY);
//        make.width.and.height.mas_equalTo(circleWH);
//    }];
    
    UIImageView * circleView = [[UIImageView alloc]init];
//    circleView.backgroundColor = [UIColor greenColor];
    circleView.image = [UIImage imageNamed:@"icon_rocker_centerImage1"];
    _circleView = circleView;
    circleView.layer.cornerRadius = circleWH / 2;
    [self addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.and.height.mas_equalTo(circleWH);
    }];
    
}

- (void)beganToCallBack {
    if (self.movingBlock) {
        self.movingBlock(self.backAngel, self.backVelocity);
    }
}

//触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.circleView.hidden = NO;
    UITouch *touch = [touches anyObject];
    self.beganPoint = [touch locationInView:self];
    
    self.backAngel = 0;
    self.backVelocity = 0;
    //倒计时开始
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(beganToCallBack) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

//触摸滑动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchMovePoint = [touch locationInView:self];
    [self makeItMove:touchMovePoint];
}
//触摸停止
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchEndPoint = [touch locationInView:self];
    [self makeItMove:touchEndPoint];
    [self endTouch];
}
//取消触摸
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchEndPoint = [touch locationInView:self];
    [self makeItMove:touchEndPoint];
    [self endTouch];
}

- (void)endTouch {
    
    [self removeTimer];
    
    if (self.movingBlock) {
        self.movingBlock(self.backAngel, self.backVelocity);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeCallBack/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
            self.movingBlock(self.backAngel/2, self.backVelocity/2);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeCallBack/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.movingBlock(0, 0);
            });
        });
    }
    
    self.circleView.center = self.center;
    
    self.circleView.image = [UIImage imageNamed:@"icon_rocker_centerImage1"];

}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)makeItMove:(CGPoint)point {
    
    CGPoint movePoint = CGPointMake(point.x - self.beganPoint.x, point.y - self.beganPoint.y);
    
    CGPoint willMoveToCenter = self.center;
    
    //moveDistance
    double moveDistance = sqrt(movePoint.x * movePoint.x + movePoint.y * movePoint.y);

    //maxMoveDistance
    double angle = [self moveAngle:movePoint];
    
    if (maxMoveDistance < moveDistance) {
        
        //超出圈外 设置最大的移动的点
        moveDistance = maxMoveDistance;
        
        CGFloat tempFabsX = fabs(maxMoveDistance * cos(angle));
        
        CGFloat tempFabsY = fabs(maxMoveDistance * sin(angle));
        if (movePoint.x > 0) {
            willMoveToCenter.x = willMoveToCenter.x + tempFabsX;
        } else if (movePoint.x < 0){
            willMoveToCenter.x = willMoveToCenter.x - tempFabsX;
        }
        
        if (movePoint.y > 0) {
            willMoveToCenter.y = willMoveToCenter.y + tempFabsY;
        } else if (movePoint.y < 0){
            willMoveToCenter.y = willMoveToCenter.y - tempFabsY;
        }
        self.circleView.image = [UIImage imageNamed:@"icon_rocker_centerImageBorder"];

    } else {
        //在圈的范围之内
        self.circleView.image = [UIImage imageNamed:@"icon_rocker_centerImage1"];
        willMoveToCenter.x = movePoint.x + willMoveToCenter.x;
        willMoveToCenter.y = movePoint.y + willMoveToCenter.y;

    }
    [self caculateAngelAndVelocityDistance:moveDistance movePoint:movePoint angel:angle];
//    self.borderImageView.center = willMoveToCenter;
    self.circleView.center = willMoveToCenter;
    
}
- (void)caculateAngelAndVelocityDistance:(CGFloat )distance movePoint:(CGPoint)movePoint angel:(double)angel{
    
    int velocity = distance / maxMoveDistance * 500;
//    NSLog(@"velocity == %d",velocity);
    CGFloat x = movePoint.x;
    CGFloat y = movePoint.y;
    double degree = radiansToDegrees(angel);
    
    //[0,359]
    int backAngel = 0;
    if (x < 0) {
        backAngel = 270 + degree;

    } else if (x == 0) {
        if (y<0) {
            backAngel = 0;
        } else if (y == 0) {
            backAngel = 0;
        } else {
            backAngel = 180;
        }
    } else {
        backAngel = 90 + degree;

    }
//    NSLog(@"x == %f,y == %f,angel == %f,backAngel == %d",x,y,radiansToDegrees(angel),backAngel);
    self.backVelocity = velocity;
    self.backAngel = backAngel;

}

- (double)moveAngle:(CGPoint)point {
    double rads = atan(point.y / point.x);
//    NSLog(@"rads == %f",radiansToDegrees(rads));
    return rads;
}


@end
