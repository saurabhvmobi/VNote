//
//  ViewController.m
//  VNote
//
//  Created by Purushottam Kumar on 06/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
- (IBAction)loginButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)hideKeyPad:(UIControl *)sender;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Hide navigation bar
    
    
//    //Inside text field image set programatically
//    UIImage *image1=[UIImage imageNamed:@"envelope32"];
//    UIImageView *imgView=[[UIImageView alloc]initWithImage:image1];
//    self.userNameTextField.leftView=imgView;
//    imgView.frame=CGRectMake(0, 2, 15, 15);
//    self.userNameTextField.leftViewMode= UITextFieldViewModeAlways;
//    
//    UIImage *image2=[UIImage imageNamed:@"key21"];
//    UIImageView *imgView2=[[UIImageView alloc]initWithImage:image2];
//    imgView2.frame=CGRectMake(0, 2, 15, 15);
//    self.passwordTextField.leftView = imgView2;
//    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;

    
    //Gardient color use in background color
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    
    
    //Text field corner setting
    _userNameTextField.layer.cornerRadius=5;
    _userNameTextField.layer.borderWidth=1;
    
    _passwordTextField.layer.cornerRadius=5;
    _passwordTextField.layer.borderWidth=1;
    
    _loginButton.layer.cornerRadius=5;
    _loginButton.layer.borderWidth=1;
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;


}




//Sign up button action
- (IBAction)signUpButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"signup" sender:self];
}

//Login button action
- (IBAction)loginButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"homePAge" sender:self];
}

//Keypad hide
- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}
@end
