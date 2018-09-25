//
//  ViewController.m
//  TableHeadSelectTagView
//
//  Created by huqi on 2018/9/21.
//  Copyright © 2018年 huqi. All rights reserved.
//

#import "ViewController.h"
#import "TabelHeadSelectTagKit.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TabelHeadSelectTagKit *headSelectTag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.headSelectTag = [[TabelHeadSelectTagKit alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 35) onView:self.view];
    
    self.headSelectTag.sourceTableView = self.tableView;
    
    TabelHeadSelectTagKitSoucreDataModel *model0 = [[TabelHeadSelectTagKitSoucreDataModel alloc] init];
    model0.title = @"titile0";
    model0.scrollIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];

    TabelHeadSelectTagKitSoucreDataModel *model1 = [[TabelHeadSelectTagKitSoucreDataModel alloc] init];
    model1.title = @"titile1";
    model1.scrollIndexPath = [NSIndexPath indexPathForRow:3 inSection:3];
    
    TabelHeadSelectTagKitSoucreDataModel *model2 = [[TabelHeadSelectTagKitSoucreDataModel alloc] init];
    model2.title = @"titile2";
    model2.scrollIndexPath = [NSIndexPath indexPathForRow:4 inSection:4];
    
    TabelHeadSelectTagKitSoucreDataModel *model3 = [[TabelHeadSelectTagKitSoucreDataModel alloc] init];
    model3.title = @"titile3";
    model3.scrollIndexPath = [NSIndexPath indexPathForRow:5 inSection:5];

    self.headSelectTag.sourceDataArray = @[model0, model1, model2, model3];
    
    self.headSelectTag.currentSelectIndex = 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"section = %ld, row = %ld", indexPath.section, indexPath.row];
    cell.contentView.backgroundColor = [self randomColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headSelectTag TabelHeadSelectTagKitOnTableView:self.tableView isNeedScrollWhileAtPoint:scrollView.contentOffset];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:((arc4random() % 256) / 255.0) green:((arc4random() % 256) / 255.0) blue:((arc4random() % 256) / 255.0) alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
