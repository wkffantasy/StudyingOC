//
//  RockerView.h
//  Ovis
//
//  Created by wangkongfei on 2019/5/9.
//  Copyright © 2019 wangkongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 @param angle    正上方为0 顺时针递增 正右90 正下180 正左270 0~359
 @param velocity 中心原点0 外圈递增
 */
typedef void(^MoveBlock)(int angle,int velocity);

@interface RockerView : UIView

@property (copy, nonatomic) MoveBlock movingBlock;

@end

NS_ASSUME_NONNULL_END
