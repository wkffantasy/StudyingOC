//
//  TabBarController.m
//  Studying
//
//  Created by wangkongfei on 2019/4/4.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import "TabBarController.h"

//controller
#import "SubclassController.h"
#import "NavigationController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UITabBar * tabbar = [UITabBar appearance];
//    tabbar.tintColor = [UIColor redColor];
//    tabbar.barTintColor = [UIColor whiteColor];
    
    [self addAllChildControllers];
    
//    self.tabBar.backgroundColor = RGBCOLOR(0, 0, 0);
    
//    self.tabBar.backgroundImage = [[UIImage alloc]init];
//    self.tabBar.shadowImage = [[UIImage alloc]init];
}

- (void)addAllChildControllers {
    
    SubclassController * demos = [[SubclassController alloc]init];
    demos.dataArray = [self allDemosArray];
    NavigationController * navi1 = [self setUpChildViewController:demos title:@"demos" normalImage:@"icon_tabbar_ovis_normalImage" selectImage:@"icon_tabbar_ovis_selectImage"];
    
    
    SubclassController * classStudy = [[SubclassController alloc]init];
    classStudy.dataArray = [self classArray];
    
    NavigationController * navi2 =[self setUpChildViewController:classStudy title:@"classStudy" normalImage:@"icon_tabbar_support_normalImage" selectImage:@"icon_tabbar_support_selectImage"];
    
    self.viewControllers = @[navi1,navi2];
}

- (NavigationController *)setUpChildViewController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    
    vc.title = title;
    vc.tabBarItem.title = title;
    
    
    UIImage * thisNormalImage =[UIImage imageNamed:normalImage];
    vc.tabBarItem.image = [thisNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateNormal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(0, 246, 246) ,NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} forState:UIControlStateSelected];
    
    return [[NavigationController alloc]initWithRootViewController:vc];
    
}

//跳转的所有的controller
#pragma  mark oc-demos
- (void)jumpToController:(NSString *)vc {
    id thisVC = [[NSClassFromString(vc) alloc]init];
    if (thisVC && [thisVC isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:thisVC animated:YES];
    }
    
}

//dataSource

- (NSArray *)classArray {
    
    NSArray * dictArray = @[
                            @{
                                @"title":@"RunTime",
                                @"titleDescription":@"runtime的一个学习",
                                @"status":@"完成吧",
                                @"jumeTo":@"RunTimeController",
                                },
                            @{
                                @"title":@"Webview and WKWebView",
                                @"titleDescription":@"试一试",
                                @"status":@"test",
                                @"jumeTo":@"WebViewController",
                                },
                            @{
                                @"title":@"baidu map",
                                @"titleDescription":@"试一试",
                                @"status":@"learning",
                                @"jumeTo":@"BaiduMapController",
                                },
                            @{
                                @"title":@"视频录制",
                                @"titleDescription":@"试一试",
                                @"status":@"learning",
                                @"jumeTo":@"VideoRecordController",
                                },
                            @{
                                @"title":@"打开相册",
                                @"titleDescription":@"试一试",
                                @"status":@"learning",
                                @"jumeTo":@"AlbumController",
                                },
                            @{
                                @"title":@"GCD学习",
                                @"titleDescription":@"多理解几次",
                                @"status":@"learning",
                                @"jumeTo":@"GCDController",
                                },
                            
                            ];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    
    for (NSDictionary * dict in dictArray) {
        
        [dataArray addObject:[self dictToHomeModel:dict]];
        
    }
    return dataArray;
    
}

- (NSArray *)allDemosArray {
    
    NSArray * dictArray = @[
                            @{
                                @"title":@"小球在大圆里滑动",
                                @"titleDescription":@"。。。。",
                                @"status":@"完成",
                                @"jumeTo":@"RockerController",
                                },
                            @{
                                @"title":@"一个可编辑的tableView的cell",
                                @"titleDescription":@"。。。。",
                                @"status":@"完成",
                                @"jumeTo":@"EditCellController",
                                },
                            @{
                                @"title":@"一个tableView的滑动带动 弧形和header的滑动",
                                @"titleDescription":@"。。。。",
                                @"status":@"完成",
                                @"jumeTo":@"MoveAnimateController",
                                },
                            @{
                                @"title":@"Label的跑马灯效果",
                                @"titleDescription":@"当文字超过一定的长度的时候，该文字会一直轮播下去，也就是跑马灯的效果",
                                @"status":@"已经完成",
                                @"jumeTo":@"MarqueeController",
                                },
                            
                            @{
                                @"title":@"字母表的滑动",
                                @"titleDescription":@"一个有section 和 cell的tableView，右侧有一个 字母表。上下滑动字母表，一个简单的动画，模仿的智联招聘",
                                @"status":@"已经完成",
                                @"jumeTo":@"AlphabetController",
                                },
                            @{
                                @"title":@"scroll item的无缝无限循环滚动",
                                @"titleDescription":@"一个scrollView 里面有好多图片 或者item，可以一直左滑 也可以一直右滑，使用frame做的，目前没有用到Masonry",
                                @"status":@"已经完成",
                                @"jumeTo":@"NoMarginScrollController",
                                },
                            @{
                                @"title":@"scroll item的间隙无限循环滚动",
                                @"titleDescription":@"scroll 的item之间是有一定的间距的，当然这个间距如果是0并且item的宽度是屏幕的宽度的话，和上一个就一模一样了，目前 这个有两点待优化，一是，item必须还得在view里面写，不能在controller里面写，这个没有封装好。二是，item滑到第一个或者最后一个，会有一个小小的闪现的问题",
                                @"status":@"待优化",
                                @"jumeTo":@"HaveMarginScrollController",
                                },
                            
                            @{
                                @"title":@"自己写的视频播放器",
                                @"titleDescription":@"目前打算写一个自己的视频播放器，在快进快退这卡住了，抽空整整，横屏也还有问题",
                                @"status":@"未完成",
                                @"jumeTo":@"VideoDemoController",
                                },
                            
                            @{
                                @"title":@"模仿拉勾app 我 界面的wave形式",
                                @"titleDescription":@"一个wave浪 一波接一波",
                                @"status":@"在写",
                                @"jumeTo":@"WaveAnimationController",
                                },
                            @{
                                @"title":@"图形验证码的生成",
                                @"titleDescription":@"简单的写",
                                @"status":@"在写",
                                @"jumeTo":@"IdentifyingCodeController",
                                },
                            @{
                                @"title":@"ImagePickerContrller",
                                @"titleDescription":@"选择照片",
                                @"status":@"在写",
                                @"jumeTo":@"ImagePickerEntranceController",
                                }
                            
                            ];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    
    for (NSDictionary * dict in dictArray) {
        
        [dataArray addObject:[self dictToHomeModel:dict]];
        
    }
    return dataArray;
    
}
- (HomeModel *)dictToHomeModel:(NSDictionary *)dict {
    
    HomeModel * model = [HomeModel new];
    model.title = dict[@"title"];
    model.titleDescription = dict[@"titleDescription"];
    model.status = dict[@"status"];
    model.jumpTo = dict[@"jumeTo"];
    return model;
    
}

@end
