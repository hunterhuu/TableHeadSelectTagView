//
//  TabelHeadSelectTagKit.m
//  TableHeadSelectTagView
//
//  Created by huqi on 2018/9/21.
//  Copyright © 2018年 huqi. All rights reserved.
//


#define COLOR(r, g, b) ([UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1])

#import "TabelHeadSelectTagKit.h"

@class TabelHeadSelectTagView;

@interface TabelHeadSelectTagKit ()

@property (nonatomic, weak) UIView *superView;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong) TabelHeadSelectTagView *selectTagView;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end

@implementation TabelHeadSelectTagKit

- (instancetype)initWithFrame:(CGRect)frame onView:(UIView *)superView {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.superView = superView;
        [self initMehtod];
    }
    return self;
}

- (void)initMehtod {
    self.selectTagView = [[TabelHeadSelectTagView alloc] initWithFrame:self.frame];
    self.selectTagView.tagKit = self;
    if (self.superView) {
        [self.superView addSubview:self.selectTagView];
    }
    self.currentSelectIndex = 0;
}

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex {
    _currentSelectIndex = currentSelectIndex;
    if (self.sourceTableView) {
        if (_currentSelectIndex < self.sourceDataArray.count) {
            NSIndexPath *jumpIndexPath = self.sourceDataArray[_currentSelectIndex].scrollIndexPath;
            [self.sourceTableView scrollToRowAtIndexPath:jumpIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
}

- (void)setSourceDataArray:(NSArray<TabelHeadSelectTagKitSoucreDataModel *> *)sourceDataArray {
    _sourceDataArray = sourceDataArray;
    if (self.selectTagView) {
        if (_sourceDataArray.count > 0) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:_sourceDataArray.count];
            for (TabelHeadSelectTagKitSoucreDataModel *tempModel in sourceDataArray) {
                [tempArray addObject:tempModel.title];
            }
            self.selectTagView.titleArray = tempArray;
        }
    }
}


- (void)TabelHeadSelectTagKitOnTableView:(UITableView *)tableView isNeedScrollWhileAtPoint:(CGPoint) point {
    if ((self.sourceTableView == tableView) && (tableView != nil)) {
        NSIndexPath *tempIndepx = [tableView indexPathForRowAtPoint:point];
        if (self.currentIndexPath == nil || self.currentIndexPath != tempIndepx) {
            self.currentIndexPath = tempIndepx;
            for (int i = (int)self.sourceDataArray.count - 1; i  >= 0; i--) {
                if ([tempIndepx compare:self.sourceDataArray[i].scrollIndexPath] == kCFCompareGreaterThan) {
                    _currentSelectIndex = i;
                    self.selectTagView.currentSelectIndex = i;
                    return;
                };
            }
        }
    }
}

@end

#pragma mark - head select tag view

@interface TabelHeadSelectTagView ()

@end

@implementation TabelHeadSelectTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMehtod];
    }
    return self;
}

- (void)initMehtod {
    self.backgroundColor = COLOR(246, 246, 246);
    self.buttonArray = [[NSMutableArray alloc] initWithCapacity:4];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    if (_titleArray == nil) {
        _titleArray = @[];
    }
    
    for (TabelHeadSelectTagButton *tagButton in self.buttonArray) {
        [tagButton removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    
    if (_titleArray.count > 0) {
        for (int i = 0; i < _titleArray.count; i++) {
            TabelHeadSelectTagButton *tagButton = [[TabelHeadSelectTagButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) / (_titleArray.count) * i, 0, CGRectGetWidth(self.bounds) / (_titleArray.count), CGRectGetHeight(self.bounds))];
            tagButton.tagView = self;
            tagButton.title = _titleArray[i];
            tagButton.index = i;
            if (self.currentSelectIndex == i) {
                tagButton.isSelect = YES;
            } else {
                tagButton.isSelect = NO;
            }
            [self addSubview:tagButton];
            [self.buttonArray addObject:tagButton];
        }
    }
}

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex {
    if (_currentSelectIndex != currentSelectIndex) {
        if (currentSelectIndex < self.buttonArray.count && _currentSelectIndex < self.buttonArray.count) {
            TabelHeadSelectTagButton *oldSelectButton = self.buttonArray[_currentSelectIndex];
            oldSelectButton.isSelect = NO;
            TabelHeadSelectTagButton *newSelectButton = self.buttonArray[currentSelectIndex];
            newSelectButton.isSelect = YES;
        }
        _currentSelectIndex = currentSelectIndex;
    }
}

@end


@implementation TabelHeadSelectTagKitSoucreDataModel

@end

#pragma mark - head select tag button

@class TabelHeadSelectTagView;

@interface TabelHeadSelectTagButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *selectNotic;
@property (nonatomic, strong) UIControl *tapControl;

@end

@implementation TabelHeadSelectTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMehtod];
    }
    return self;
}

- (void)initMehtod {
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titleLabel];
    self.titleLabel.center = CGPointMake(self.titleLabel.center.x, 6 + 10);
    
    self.selectNotic = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bounds) - 2, 25, 2)];
    self.selectNotic.backgroundColor = COLOR(225, 85, 46);
    [self addSubview:self.selectNotic];
    self.selectNotic.center = CGPointMake(self.titleLabel.center.x, self.selectNotic.center.y);
    
    self.isSelect = NO;
    self.title = @"";
    
    self.tapControl = [[UIControl alloc] initWithFrame:self.bounds];
    [self.tapControl addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tapControl];
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (_isSelect) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = COLOR(225, 85, 46);
        self.selectNotic.hidden = NO;
    } else {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = COLOR(102, 102, 102);
        self.selectNotic.hidden = YES;
    }
}

- (void)didClick:(UIControl *)control {
    self.tagView.tagKit.currentSelectIndex = self.index;
    self.tagView.currentSelectIndex = self.index;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
