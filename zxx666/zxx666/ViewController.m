//
//  ViewController.m
//  zxx666
//
//  Created by JianXin on 16/2/20.
//  Copyright © 2016年 JianXin. All rights reserved.
//

#import "ViewController.h"

#import "MJRefresh.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int a;
}

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (strong, nonatomic) UITableView *dddTable;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *contentLbl;

@property (strong, nonatomic) UIButton *infoButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    a = 0;
    
    _dataArray = [NSMutableArray arrayWithObjects:@"a", @"恭", @"喜", @"发", @"财", nil];
    _dataArr = [NSMutableArray arrayWithObjects:
//                @"二傻子",
//                @"恭喜zxx中了一个滑板鞋",
                @"恭喜猩猩中了一根香蕉",
                @"恭喜猴子请来了救兵",
                @"大傻子",
                @"二傻子",
                @"恭喜zxx中了一个滑板鞋", nil];

    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 60)];
    
//    self.contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 30)];
//    _contentLbl.text = _dataArr[0];
//    
//    [self.backView addSubview:_contentLbl];
    
    self.infoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 375, 30)];
    [_infoButton setTitle:_dataArr[0] forState:UIControlStateNormal];
    [_infoButton addTarget:self action:@selector(showInfoDetail:) forControlEvents:UIControlEventTouchUpInside];
    [_infoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backView addSubview:_infoButton];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 150)];
    [img setImage:[UIImage imageNamed:@"1.jpg"]];
    
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(change:) userInfo:nil repeats:YES];
    
    _dddTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 375, 627) style:UITableViewStylePlain];
    _dddTable.delegate = self;
    _dddTable.dataSource = self;
    _dddTable.tableHeaderView = img;
    [self.view addSubview:_dddTable];
    
    
    // 下拉刷新
    [_dddTable addLegendHeaderWithRefreshingBlock:^{
        
        // 刷新后初始化数组, 更新数据
        _dataArray = [NSMutableArray arrayWithObjects:@"a", @"一", @"路", @"顺", @"风", nil];
        [_dddTable.header endRefreshing];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
        _dddTable.tableHeaderView = img;
        
        a = -1;
        
        [_dddTable reloadData];
    }];
    
}

// 定时器调用方法, 更新中奖信息
- (void)change:(NSTimer *)timer
{
    // 取数组下一个数据
    a ++;

//    self.contentLbl.text = _dataArr[a];
    [self.infoButton setTitle:_dataArr[a] forState:UIControlStateNormal];

    // 每次设置label的frame, 为了显示从上到下的动画效果
    self.infoButton.frame = CGRectMake(0, 0, 375, 30);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.infoButton.frame = CGRectMake(0, -30, 375, 30);
    } completion:^(BOOL finished) {
        self.infoButton.frame = CGRectMake(0, 0, 375, 30);
    }];
    
    // 取到数组最后一个数据时, 重新赋值为-1, 从数组第一个数据开始再次显示
    if (a == _dataArr.count - 1) {
        a = -1;
    }

    
}

- (void)showInfoDetail:(id)sender
{
    NSString *clickNum = [NSString stringWithFormat:@"点击的是第%d个中奖信息", a];
    // 初始化UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:clickNum preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定后调用的方法");
    }];
    
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消后调用的方法");
    }];
    
    // 添加按钮
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    } else {
        return 60;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"movieIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0) {

        [cell.contentView addSubview:_backView];
        
    } else {
        
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
