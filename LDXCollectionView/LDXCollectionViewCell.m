//
//  LDXCollectionViewCell.m
//  LDXCollectionView
//
//  Created by test on 2018/5/21.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LDXCollectionViewCell.h"

@implementation LDXCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 20;
}
@end
