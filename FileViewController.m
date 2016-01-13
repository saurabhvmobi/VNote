//
//  FileViewController.m
//  VNote
//
//  Created by Purushottam Kumar on 09/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "FileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FileModelData.h"
#import "NotesDetail.h"
#import "AppDelegate.h"


@interface FileViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIImage *myImage;
    UIImagePickerController *picker;
    NSString *fileName;
    NSString *textName;
    FileModelData *fModel;
    NSMutableArray *fileTableArray;
    NSIndexPath *indexpath;
    AppDelegate *appdel;

}
@property (weak, nonatomic) IBOutlet UIView *tapToCreateAttachFileView;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
- (IBAction)tapToAttachFile1:(UIButton *)sender;
- (IBAction)hideKeypad:(id)sender;
- (IBAction)saveFileButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *fileNameTextFieldItem;
@property (weak, nonatomic) IBOutlet UITextView *textViewItem;
@property (weak, nonatomic) IBOutlet UITextField *fileNameTextField2;
@property (weak, nonatomic) IBOutlet UITextView *textViewField2;
@property (weak, nonatomic) IBOutlet UILabel *fileNameTextLabel;

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appdel =[UIApplication sharedApplication].delegate;
    
    fileTableArray=[[NSMutableArray alloc]init];
    self.navigationItem.title=@"File";
    
    //Hide backBar Button
    self.navigationItem.hidesBackButton=YES;
    
    
    //Gardient color use in background color
    
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    

    
    myImage = [UIImage imageNamed:@"direction196"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    
    // myButton.showsTouchWhenHighlighted = YES;
    myButton.frame = CGRectMake(10.0, 0.0,24,24);
    
    [myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = leftButton;

    _fileNameTextFieldItem.textColor=[UIColor whiteColor];
    _myTextView.textColor=[UIColor whiteColor];
    _myTextView.textColor=[UIColor whiteColor];
    _myTextView.textColor=[UIColor whiteColor];
    
    
    _myTextView.text=@"";
    _myTextView.textColor=[UIColor whiteColor];
    _myTextView.delegate=self;
    
    _myTextView.layer.cornerRadius=5;
    _myTextView.layer.borderWidth=1;
    _myTextView.layer.borderColor=([UIColor colorWithRed:0.22 green:0.59 blue:0.85 alpha:1.0].CGColor);
    
    _tapToCreateAttachFileView.layer.cornerRadius=5;
    _tapToCreateAttachFileView.layer.borderWidth=1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
    
    self.fileNameTextLabel.hidden=YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *steText=self.myTextView.text;
    self.fileNameTextLabel.hidden=YES;
    if (steText.length==0)
    {
        self.fileNameTextLabel.hidden=NO;
        [textView addSubview:_fileNameTextLabel];
    }
    return YES;
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
- (IBAction)tapToAttachFile1:(UIButton *)sender
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Attach file from:"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Gallery", @"Camera", nil];
    
    
    
    [actionSheet showInView:self.view];
    [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    

}

- (IBAction)hideKeypad:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)saveFileButtonAction:(UIButton *)sender
{
    fileName=_fileNameTextFieldItem.text;
    textName=_textViewItem.text;
    
    NSMutableString *mutableString=[[NSMutableString alloc]init];
    BOOL goodToGo=YES;
    
    
    if (fileName.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"File name is required\n"];
    }
    if (textName.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"Enter the text"];

    }
    if ((!goodToGo))
    {
        
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Alert !!"
                                              message:mutableString
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                           
                                       }];
        
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    if (goodToGo)
    {
        
        [self localData];
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Successfully !!" message:@"Your note save successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    
}






-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (picker == nil)
    {
        picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        
    }
    
    
    if (buttonIndex == 0)
        
    {
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:Nil];
        
        
    }
    else if (buttonIndex == 1)
    {
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:Nil];
    }
    else
    {
        
        //        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        //        [self presentViewController:picker animated:YES completion:Nil];
        
    }
    
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
            
        default:
            break;
    }
}







-(void)localData
{
    fModel=[[FileModelData alloc]init];
    
    fModel.foldername = self.currentFoldername;
    fModel.titleName=fileName;
    fModel.texTName=textName;
    
    
    [fileTableArray addObject:fModel];
    appdel.allfile = [appdel.allfile arrayByAddingObjectsFromArray:fileTableArray ];
    
    
}


@end
