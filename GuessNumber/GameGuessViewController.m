//
//  ViewController.m
//  GuessNumber
//
//  Created by renxuan on 15/11/17.
//  Copyright © 2015年 renxuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (UITextField *)create_text_field_with_frame : (CGRect)frame
{
    UITextField *text_field = [[UITextField alloc]initWithFrame:frame];
    text_field.delegate = self;
    text_field.font = [UIFont fontWithName:@"Arial" size:24.0];
    text_field.textAlignment = UITextAlignmentCenter;
    text_field.keyboardType = UIKeyboardTypeNumberPad;
    text_field.textColor = [UIColor colorWithRed:44.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
    [self.view addSubview:text_field];
//    [text_field addTarget:self
//                   action:@selector(textFieldDidChange:)
//         forControlEvents:UIControlEventEditingChanged];
    return text_field;
}
- (void)dismiss_key_board
{
    [m_text_field_phone_number resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    fillNumber_one = [self create_text_field_with_frame:CGRectMake(100, 400, 30, 30)];
    fillNumber_two = [self create_text_field_with_frame:CGRectMake(140, 400, 30, 30)];
    fillNumber_three = [self create_text_field_with_frame:CGRectMake(180, 400, 30, 30)];
    fillNumber_four = [self create_text_field_with_frame:CGRectMake(2200, 400, 30, 30)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss_key_board)];
    [self.view addGestureRecognizer:tap];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
