//
//  ViewController.h
//  LDXCollectionView
//
//  Created by test on 2018/5/21.
//  Copyright © 2018年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDXCollectionViewFlowLayout.h"

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *ldxCollectionView;
@property (weak, nonatomic) IBOutlet LDXCollectionViewFlowLayout *ldxCollectionViewFlowLayout;
@property (nonatomic, assign) CGPoint oldScrollerViewContent;    //collectionView每次滑动后的偏移量
@end

