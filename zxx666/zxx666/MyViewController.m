//
//  MyViewController.m
//  zxx666
//
//  Created by JianXin on 16/3/2.
//  Copyright © 2016年 JianXin. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (strong, nonatomic) UILabel *myLabel;
@property (strong, nonatomic) NSMutableArray *titleArr;
@property (assign, nonatomic) NSInteger num;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleArr = [NSMutableArray arrayWithObjects:@"11111111111", @"222222222", @"3333333333", nil];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 59, 224, 21)];
    self.myLabel.text = @"aaaaaaaaaa";
    _myLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_myLabel];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeContent:) userInfo:nil repeats:YES];
}

- (void)changeContent:(NSTimer *)timer
{
    _num ++;
    self.myLabel.text = _titleArr[_num];
    
    self.myLabel.frame = CGRectMake(8, 38, 224, 21);
    
    [UIView beginAnimations:@"k" context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    self.myLabel.frame = CGRectMake(8, 59, 224, 21);

    
    [UIView commitAnimations];
    self.myLabel.frame = CGRectMake(8, 59, 224, 21);


//    [UIView animateWithDuration:1 animations:^{
//        
//        _myLabel.frame = CGRectMake(8, 38, 224, 21);
//        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeContent:) userInfo:nil repeats:YES];
//
//        
//    }];
    
    if (_num == 2) {
        _num = -1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
