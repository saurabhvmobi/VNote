//
//  SignUp.m
//  VNote
//
//  Created by Purushottam Kumar on 06/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "SignUp.h"
#import <QuartzCore/QuartzCore.h>

@interface SignUp ()
- (IBAction)alreadyHaveAccountButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)signUpButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIView *firstName;
@property (weak, nonatomic) IBOutlet UIView *lastName;
@property (weak, nonatomic) IBOutlet UIView *userName;
@property (weak, nonatomic) IBOutlet UIView *emailText;
@property (weak, nonatomic) IBOutlet UIView *password;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];

    
    _firstName.layer.cornerRadius=5;
    _firstName.layer.borderWidth=1;
    
    
    _lastName.layer.cornerRadius=5;
    _lastName.layer.borderWidth=1;
    
    _userName.layer.cornerRadius=5;
    _userName.layer.borderWidth=1;
    
    _emailText.layer.cornerRadius=5;
    _emailText.layer.borderWidth=1;
    
    _password.layer.cornerRadius=5;
    _password.layer.borderWidth=1;

    _signUp.layer.cornerRadius=5;
    _signUp.layer.borderWidth=1;






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

- (IBAction)alreadyHaveAccountButtonAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)signUpButtonAction:(UIButton *)sender {
}

- (IBAction)hideKeypad:(id)sender
{
    [self.view endEditing:YES];
}

@end
