//
//  LDXCollectionViewFlowLayout.m
//  LDXCollectionView
//
//  Created by test on 2018/5/21.
//  Copyright © 2018年 test. All rights reserved.
//

#import "LDXCollectionViewFlowLayout.h"
#define Ratio 4  //左右两侧cell的告诉缩放，越小高度越低

@implementation LDXCollectionViewFlowLayout
/**
 *  只要手一松开就会调用
 *  这个方法的返回值，就决定了CollectionView停止滚动时的偏移量
 *  proposedContentOffset这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
 *  velocity  是滚动速率  有个x和y 如果x有值 说明x上有速度
 *  如果y有值 说明y上又速度 还可以通过x或者y的正负来判断是左还是右（上还是下滑动）  有时候会有用
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //collectionView的本应该的最终frame
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    //在最终区域的cell属性数组
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width/2 + proposedContentOffset.x;
    //存放的最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x+=minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    return proposedContentOffset;
}

/**
 *  这个方法的返回值是一个数组(数组里存放在rect范围内所有元素的布局属性)
 *  这个方法的返回值  决定了rect范围内所有元素的排布（frame）
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{   //获得super已经计算好的布局属性 只有线性布局才能使用
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    //计算CollectionView最中心的x值
    //#warning 特别注意：
    CGFloat centetX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        //CGFloat scale = arc4random_uniform(100)/100.0;
        //attrs.indexPath.item 表示 这个attrs对应的cell的位置
        //cell的中心点x 和CollectionView最中心点的x值
        CGFloat delta = ABS(attrs.center.x - centetX);
        //根据间距值  计算cell的缩放的比例
        //这里scale 必须要 小于1
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width/Ratio;
        //设置缩放比例
        attrs.transform3D = CATransform3DMakeScale(1.0, scale, 1.0);
    }
    return array;
}

/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
