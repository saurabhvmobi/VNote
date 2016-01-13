//
//  NotesDescriptionViewController.m
//  VNote
//
//  Created by Purushottam Kumar on 11/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "NotesDescriptionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface NotesDescriptionViewController ()<UITextViewDelegate>
{
    UIImage *myImage;
    AppDelegate *appDel;
}

@property (weak, nonatomic) IBOutlet UITextView *myNotesDescTextView;
@property (weak, nonatomic) IBOutlet UILabel *myFileNameLabel;

@end

@implementation NotesDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _myNotesDescTextView.textColor=[UIColor whiteColor];
    _myNotesDescTextView.textColor=[UIColor whiteColor];
    _myNotesDescTextView.textColor=[UIColor whiteColor];
    
    
    _myNotesDescTextView.text=@"";
    _myNotesDescTextView.textColor=[UIColor whiteColor];
    _myNotesDescTextView.delegate=self;
    
//    _myNotesDescTextView.layer.cornerRadius=5;
//    _myNotesDescTextView.layer.borderWidth=1;
//    _myNotesDescTextView.layer.borderColor=([UIColor colorWithRed:0.22 green:0.59 blue:0.85 alpha:1.0].CGColor);

    
    self.myFileNameLabel.text=self.descModel.titleName;
    self.myNotesDescTextView.text=self.descModel.texTName;
    //Hide backBar Button
    self.navigationItem.hidesBackButton=YES;
    
    
    myImage = [UIImage imageNamed:@"direction196"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    
    // myButton.showsTouchWhenHighlighted = YES;
    myButton.frame = CGRectMake(10.0, 0.0,24,24);
    
    [myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    self.navigationItem.title=@"Note Details";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    //Gardient color use in background color
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    

    // Do any additional setup after loading the view.
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
-(void)tapped
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
