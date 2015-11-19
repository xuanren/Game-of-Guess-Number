//
//  ViewController.m
//  GuessNumber
//
//  Created by renxuan on 15/11/17.
//  Copyright © 2015年 renxuan. All rights reserved.
//

#import "GameGuessViewController.h"

@interface GameGuessViewController ()
{
//    int count_a;
//    int count_b;
}

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
- (UILabel *)create_label_with_frame : (CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor redColor];
    label.font = [UIFont fontWithName:@"Arial" size:12.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:208.0/255.0 green:2.0/255.0 blue:27.0/255.0 alpha:1.0];
    label.text = @"";
    [self.view addSubview:label];
    return label;
}
- (void)create_label_with_title :(NSString *)title :(CGRect)frame :(double)font_size :(UIColor *)color
{
    UILabel *name_notifiction_label = [[UILabel alloc]initWithFrame:frame];
    name_notifiction_label.textAlignment = NSTextAlignmentCenter;
    name_notifiction_label.font = [UIFont fontWithName:@"Arial" size:font_size];
    
    name_notifiction_label.text = title;
    name_notifiction_label.textColor = color;
    [self.view addSubview:name_notifiction_label];
}

- (void)dismiss_key_board
{
    [m_text_field_phone_number resignFirstResponder];
}
- (void)add_fill_number
{
    fillNumber_one = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 400)/2 + 50, 222, 40, 40)];
    fillNumber_two = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 400)/2 + 50 * 2, 222, 40, 40)];
    fillNumber_three = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 400)/2 + 50 * 3, 222, 40, 40)];
    fillNumber_four = [self create_text_field_with_frame:CGRectMake((self.view.frame.size.width - 400)/2 +
                                                                    50 * 4, 222, 40, 40)];
}
- (void)add_start_button
{
    begin_button = [self create_button_with_frame :@"开始游戏" :CGRectMake((self.view.frame.size.width - 120)/2, 310, 100, 50) :@selector(generating_the_digital:)];
    enter_number = [self create_button_with_frame:@"确定" :CGRectMake(self.view.frame.size.width - 100, 222, 60, 40) :@selector(enter_different_number:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self add_fill_number];
    [self add_start_button];

    error_digital = [self create_label_with_frame:CGRectMake((self.view.frame.size.width - 170)/2, 280, 150, 30)];
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
        NSLog(@"result");
    }
    return resultArray;
}
-(void)enter_different_number:(id)sender
{
    fillNumber_all = [[NSArray alloc]initWithObjects:fillNumber_one.text, fillNumber_two.text, fillNumber_three.text, fillNumber_four.text, nil];

        for (int j=1; j<4; j++) {
            for (int k=0; k<j; k++) {
                if (fillNumber_all[k] != fillNumber_all[j])
                    [self compare_with_number];
                else
                    error_digital.text = @"请重新输入不同的数字";
                    }
        }
}
-(void)compare_with_number
{
    int count_a = 0;
    int count_b = 0;
    for (int a = 0; a < fillNumber_all.count; a ++) {
        for (int b = 0; b < resultArray.count; b ++) {
            if (fillNumber_all[a] == resultArray[b]) {
                if (a == b){
                    count_a = count_a + 1;
                }
                else{
                    count_b = count_b + 1;
                }
            }
        }
        NSString *count_title = [NSString stringWithFormat:@"%dA%dB",count_a,count_b];
        [self create_label_with_title :count_title :CGRectMake((self.view.frame.size.width - 120)/2, 150, 100, 50):24.0 :[UIColor colorWithRed:208.0/255.0 green:2.0/255.0 blue:27.0/255.0 alpha:1.0]];
    }
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
        if ([toBeString length] > 1) {
            textField.text = [toBeString substringToIndex:1];
            return NO;
        }
    }
            return YES;
}
@end
