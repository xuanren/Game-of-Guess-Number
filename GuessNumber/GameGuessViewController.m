//
//  ViewController.m
//  GuessNumber
//
//  Created by renxuan on 15/11/17.
//  Copyright © 2015年 renxuan. All rights reserved.
//

#import "GameGuessViewController.h"

@interface GameGuessViewController ()

@end

@implementation GameGuessViewController

- (UITextField *)create_text_field_with_frame : (CGRect)frame
{
    UITextField *text_field = [[UITextField alloc]initWithFrame:frame];
    text_field.delegate = self;
    text_field.font = [UIFont fontWithName:@"Arial" size:24.0];
    text_field.textAlignment = UITextAlignmentCenter;
    text_field.keyboardType = UIKeyboardTypeNumberPad;
    text_field.layer.masksToBounds=YES;
    text_field.layer.borderWidth=1.0;
    text_field.layer.cornerRadius = 5.0;
    [text_field becomeFirstResponder];
    text_field.textColor = [UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
    [self.view addSubview:text_field];
    return text_field;
}
- (UIButton *)create_button_with_frame : (NSString *)title :(CGRect)frame :(SEL)sel_pressed
{
    UIButton *start_button = [UIButton buttonWithType:UIButtonTypeSystem];
    start_button.frame = frame;
    [start_button setTitle:title forState:UIControlStateNormal];
    start_button.layer.masksToBounds=YES;
    start_button.layer.borderWidth=1.0;
    start_button.layer.cornerRadius = 5.0;
    [start_button addTarget:self action:sel_pressed forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start_button];
    return start_button;
}

- (void)dismiss_key_board
{
    [m_text_field_phone_number resignFirstResponder];
}
- (void)add_fill_number
{
    fillNumber_one = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 310)/2 + 50, 222, 40, 40)];
    fillNumber_two = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 310)/2 + 50 * 2, 222, 40, 40)];
    fillNumber_three = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 310)/2 + 50 * 3, 222, 40, 40)];
    fillNumber_four = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 310)/2 +
                                                                    50 * 4, 222, 40, 40)];
    fillNumber_all = [[NSArray alloc]initWithObjects:fillNumber_one, fillNumber_two, fillNumber_three, fillNumber_four, nil];
}
- (void)add_start_button
{
    begin_button = [self create_button_with_frame :@"开始游戏" :CGRectMake((self.view.frame.size.width - 120)/2, 310, 100, 50) :@selector(generating_the_digital:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self add_fill_number];
    [self add_start_button];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss_key_board)];
    [self.view addGestureRecognizer:tap];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray *)generating_the_digital:(id)sender
{
    //随机数从这里边产生
    startArray=[[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    //随机数产生结果
    resultArray=[[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    NSInteger m=4;
    for (int i=0; i<m; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}
//限制只能输入一个字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([fillNumber_one isEqual:textField]||[fillNumber_two isEqual:textField]||[fillNumber_three isEqual:textField]||[fillNumber_four isEqual:textField])
        //判断是否时我们想要限定的那个输入框
    {
//        for (int j=0; j<fillNumber_all.count; j++) {
//            if ([fillNumber_all isEqual:textField]) {
//                <#statements#>
//            }
//        }
        if ([toBeString length] > 1) {
            //如果输入框内容大于1则弹出警告
            textField.text = [toBeString substringToIndex:1];
            return NO;
        }
    }
    return YES;
}
@end
