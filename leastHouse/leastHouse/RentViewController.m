//
//  RentViewController.m
//  leastHouse
//
//  Created by DOO on 2016/7/28.
//  Copyright © 2016年 DOO. All rights reserved.
//

#import "RentViewController.h"
#import "LeastViewController.h"
#import "Least.h"
@import UIKit;


@interface RentViewController ()<UITextFieldDelegate>{
    UITextField * editingTextField;
    CGFloat keyboardHeight;
}
@property (weak, nonatomic) IBOutlet UITextField *renter;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *addressName;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *year;
@property (weak, nonatomic) IBOutlet UITextField *beginningYear;
@property (weak, nonatomic) IBOutlet UITextField *deadlineYear;
@property (weak, nonatomic) IBOutlet UITextField *rent;
@property (weak, nonatomic) IBOutlet UITextField *rentDeposit;
@property (weak, nonatomic) IBOutlet UITextField *deadline;

@property (weak, nonatomic) IBOutlet UITextField *dateOfContract;
@property (weak, nonatomic) IBOutlet UITextField *notations;

@property(nonatomic)UIDatePicker *datePicker;

@end

@implementation RentViewController
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [textField resignFirstResponder];
    
    return YES;
    
}


//輸入框編輯完成以後，將視圖恢復到原始狀態

-(void)textFieldDidEndEditing:(UITextField *)textField

{
    
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}



//開始編輯輸入框的時候，軟鍵盤出現，執行此事件

-(void)textFieldDidBeginEditing:(UITextField *)textField

{
    

    if(textField.tag == 99){
        return;
    }
    
    CGRect frame = self.view.frame;
    
    if (keyboardHeight != 0){
       frame.origin.y -= keyboardHeight;
    }else{
        
        frame.origin.y -= 250;
    }
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = frame;
    } completion:nil];
}







- (IBAction)save:(id)sender {
    
    //[[self.delegate leasts] indexOfObject:self.least];
    self.nowleast.renter = self.renter.text;
    self.nowleast.tel = self.tel.text;
    self.nowleast.addressName = self.addressName.text;
    self.nowleast.address = self.address.text;
    self.nowleast.year = self.year.text;
    self.nowleast.beginningYear = self.beginningYear.text;
    self.nowleast.deadlineYear = self.deadlineYear.text;
    self.nowleast.rent = self.rent.text;
    self.nowleast.rentDeposit = self.rentDeposit.text;
    self.nowleast.deadline = self.deadline.text;
    self.nowleast.notations = self.notations.text;
    self.nowleast.dateOfContract = self.dateOfContract.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.renter.text= self.nowleast.renter;
    self.tel.text = self.nowleast.tel;
    self.addressName.text = self.nowleast.addressName;
    self.address.text = self.nowleast.address;
    self.year.text =  self.nowleast.year;
    self.rent.text = self.nowleast.rent;
    self.rentDeposit.text = self.nowleast.rentDeposit;
    self.deadline.text = self.nowleast.deadline;
    self.notations.text = self.nowleast.notations;
    
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.beginningYear.inputView = self.datePicker;
    self.deadlineYear.inputView = self.datePicker;
    self.dateOfContract.inputView = self.datePicker;
    
    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:YES];
//    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    self.datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:1820* 24 * 60 * 60];
    
    UIToolbar *datePickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 34)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dateDone:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    datePickerToolBar.items = [NSArray arrayWithObjects:space,done, nil];
    
    self.beginningYear.inputAccessoryView = datePickerToolBar;
    self.deadlineYear.inputAccessoryView = datePickerToolBar;
    self.dateOfContract.inputAccessoryView = datePickerToolBar;

    
    [self.beginningYear addTarget:self action:@selector(update:) forControlEvents:UIControlEventEditingDidEnd];
    [self.deadlineYear addTarget:self action:@selector(update:) forControlEvents:UIControlEventEditingDidEnd];
     [self.dateOfContract addTarget:self action:@selector(update:) forControlEvents:UIControlEventEditingDidEnd];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification*)notification{
    keyboardHeight = [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
    
}

-(void)update:(UITextField*)text{
    NSDate *selectDate = [self.datePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
  
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *dataFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd " options:0 locale:[NSLocale systemLocale]];
    formatter.dateFormat = dataFormat;
    
    text.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:selectDate]];
    
}

-(void)dateDone:(UIDatePicker*)datePicker{
    
    
    [self.beginningYear resignFirstResponder];
    [self.deadlineYear resignFirstResponder];
    [self.dateOfContract resignFirstResponder];
    
    
    
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
