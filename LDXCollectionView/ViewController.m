//
//  ViewController.m
//  LDXCollectionView
//
//  Created by test on 2018/5/21.
//  Copyright © 2018年 test. All rights reserved.
//

#import "ViewController.h"
#import "LDXCollectionViewCell.h"
#define ItemSize CGSizeMake(270, 300)
#define padding 10

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupCollectionView];
}

/**
 初始化CollectionView
 */
- (void)setupCollectionView {
    self.ldxCollectionView.frame = CGRectMake(0, 200, 375, ItemSize.height);
    self.ldxCollectionView.contentInset = UIEdgeInsetsMake(0, (self.view.frame.size.width - ItemSize.width)/2, 0, (self.view.frame.size.width - ItemSize.width)/2);
    self.ldxCollectionViewFlowLayout.minimumLineSpacing = padding;
    self.ldxCollectionViewFlowLayout.minimumInteritemSpacing = padding;
    self.ldxCollectionViewFlowLayout.itemSize = ItemSize;
    self.oldScrollerViewContent = self.ldxCollectionView.contentOffset;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LDXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDXCollectionViewCell" forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LDXCollectionViewCell *cell = (LDXCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect cellFrame = [collectionView convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
        //该判断是为了只对页面中间的cell有点击效果
    if (fabs(cellFrame.size.height - ItemSize.height) < 1) {
        NSLog(@"只可以点击中间的cell");
    }
}

#pragma mark -UIScrollViewDelegate

//实现每次只能滑动一个cell
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    double destination = targetContentOffset->x;
    double old = _oldScrollerViewContent.x;
    if (destination - old > (ItemSize.width + padding)/3) {
        targetContentOffset->x = old + ItemSize.width + padding;
    }else if (old - destination > (ItemSize.width + padding)/3) {
        targetContentOffset->x = old - ItemSize.width - padding;
    }
    _oldScrollerViewContent = CGPointMake(targetContentOffset->x, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
