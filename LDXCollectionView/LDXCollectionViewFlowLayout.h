//
//  LDXCollectionViewFlowLayout.h
//  LDXCollectionView
//
//  Created by test on 2018/5/21.
//  Copyright © 2018年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDXCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat ActiveDistance;  //垂直缩放除以系数
@property (nonatomic, assign) CGFloat ScaleFactor;   //缩放系数  越大缩放越大
@end
