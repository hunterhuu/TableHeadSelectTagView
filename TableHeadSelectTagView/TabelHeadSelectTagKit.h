//
//  TabelHeadSelectTagKit.h
//  TableHeadSelectTagView
//
//  Created by huqi on 2018/9/21.
//  Copyright © 2018年 huqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark TabelHeadSelectTagKit

@class TabelHeadSelectTagKitSoucreDataModel;
@interface TabelHeadSelectTagKit : NSObject

@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) NSArray <TabelHeadSelectTagKitSoucreDataModel *>*sourceDataArray; // 源数据
@property (nonatomic, weak) UITableView *sourceTableView;
- (instancetype)initWithFrame:(CGRect)frame onView:(UIView *)superView;
- (void)TabelHeadSelectTagKitOnTableView:(UITableView *)tableView isNeedScrollWhileAtPoint:(CGPoint) point;

@end

@interface TabelHeadSelectTagKitSoucreDataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSIndexPath *scrollIndexPath;

@end

#pragma mark -
#pragma mark TabelHeadSelectTagButton

@class TabelHeadSelectTagButton;

@interface TabelHeadSelectTagView : UIView

@property (nonatomic, weak) TabelHeadSelectTagKit *tagKit;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) NSMutableArray <TabelHeadSelectTagButton *>*buttonArray;
@property (nonatomic, strong) NSArray <NSString *>*titleArray;

@end


#pragma mark -
#pragma mark TabelHeadSelectTagButton

@interface TabelHeadSelectTagButton : UIView

@property (nonatomic, weak) TabelHeadSelectTagView* tagView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) NSInteger index;

@end
