//
//  RockerController.m
//  Studying
//
//  Created by wangkongfei on 2019/5/29.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import "RockerController.h"

//views
#import "RockerView.h"

@interface RockerController ()

@property (weak, nonatomic) UILabel * showLabel;

@end

@implementation RockerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupViews];
    
    [self.titleView updateText:@"摇杆" andTitleFont:nil andTitleColor:nil];
}

#pragma mark - all views build
- (void)setupViews {
    
    UILabel * showLabel = [[UILabel alloc]init];
    showLabel.text = @"";
    showLabel.textColor = [UIColor greenColor];
    showLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:showLabel];
    _showLabel = showLabel;
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.updateExisting = YES;
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(100);
    }];
    
    //rocker container
    CGFloat rockerWH = 200;
    CGFloat margin = 45;
    UIView * rockerContainerView = [[UIView alloc]init];
    rockerContainerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rockerContainerView];
    [rockerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(rockerWH);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-margin);
    }];
    
    //rocker view
    RockerView * rockerView = [[RockerView alloc]init];
    @weakify(self);
    rockerView.movingBlock = ^(int angle, int velocity) {
        @strongify(self);
        self.showLabel.text = [NSString stringWithFormat:@"angle == %0.1f ,velocity == %0.1f",(float)angle,(float)velocity];
        [self xxx];
    };
    rockerView.frame = CGRectMake(0, 0, rockerWH, rockerWH);
    [rockerContainerView addSubview:rockerView];
    
    
    
}
- (void)xxx {
   
    static NSString * a = @"10";
    NSLog(@"a22 == %p ",a);
}


@end
