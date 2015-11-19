//
//  GameGuessViewController.h
//  GuessNumber
//
//  Created by renxuan on 15/11/17.
//  Copyright © 2015年 renxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface GameGuessViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *fillNumber_one;
    UITextField *fillNumber_two;
    UITextField *fillNumber_three;
    UITextField *fillNumber_four;
    UITextField *m_text_field_phone_number;
    
    UIButton *begin_button;
    UIButton *enter_number;
    UILabel  *error_digital;
    NSMutableArray *startArray;
    NSMutableArray *resultArray;
    NSArray        *fillNumber_all;
}


@end

