//
//  FolderViewController.m
//  VNote
//
//  Created by Purushottam Kumar on 07/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "FolderViewController.h"
#import "FolderModelData.h"
#import "HomePage.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface FolderViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *tabArray;
    FolderModelData *bModel;
    NSString *folder1;
    NSString *title1;
    NSString *text1;
    FolderModelData *cModel;
}
- (IBAction)attachmentButtonAction:(UIButton *)sender;
- (IBAction)homeBackButtonAction:(UIButton *)sender;
- (IBAction)hideKeyPad:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *folder;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *textView;
- (IBAction)folderRightBarButtonAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *tapToAttachFile;
- (IBAction)saveFolderButoonAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *folderNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fileNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *textViewField;
@property (weak, nonatomic) IBOutlet UILabel *placeholderNameLabel;

@end

@implementation FolderViewController
{
    UIImagePickerController *picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.title=@"Folder";
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
   
    //Gardient color use in background color

    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    
    
    //Set view corner
    _tapToAttachFile.layer.cornerRadius=5;
    _tapToAttachFile.layer.borderWidth=1;
    
    //Change the text field value color
    _folderNameTextField.textColor=[UIColor whiteColor];
    _fileNameTextField.textColor=[UIColor whiteColor];
    _textViewField.textColor=[UIColor whiteColor];
    
    
    _textViewField.text=@"";
    _textViewField.textColor=[UIColor whiteColor];
    _textViewField.delegate=self;
    
    _textViewField.layer.cornerRadius=5;
    _textViewField.layer.borderWidth=1;
    _textViewField.layer.borderColor=([UIColor colorWithRed:0.22 green:0.59 blue:0.85 alpha:1.0].CGColor);
    
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;

    if (appDel.allNotes == nil)
    {
        tabArray=[[NSMutableArray alloc]init];
    }else
    {
        tabArray = appDel.allNotes;
    }
    
//    _folder.layer.cornerRadius=5;
//    _folder.layer.borderWidth=1;
    
    
//    _textView.layer.cornerRadius=5;
//    _textView.layer.borderWidth=1;
    
//    _titleView.layer.cornerRadius=5;
//    _titleView.layer.borderWidth=1;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
   

    
            self.placeholderNameLabel.hidden=YES;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    NSString *strText=self.textViewField.text;
    
    self.placeholderNameLabel.hidden=YES;
       
    if (strText.length==0)
    {
        
        
        self.placeholderNameLabel.hidden=NO;
        [textView addSubview:_placeholderNameLabel];
        

        
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


//Attachment of image from camera gallery
- (IBAction)attachmentButtonAction:(UIButton *)sender
{
//    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
//    picker.delegate=self;
//    picker.allowsEditing=YES;
//    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:picker animated:YES completion:Nil];
//    
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Attach file from:"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Gallery", @"Camera", nil];
    
  
    
    [actionSheet showInView:self.view];
    [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];

    
}

//Perform custom back button
- (IBAction)homeBackButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)hideKeyPad:(id)sender
{
    [self.view endEditing:YES];
}

//Save selected image from gallery to any where

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *image=info[UIImagePickerControllerEditedImage];
//    self.myImage.image=image;
//    
//    //To save the taken photo in a phone library
//    
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    [picker dismissViewControllerAnimated:YES completion:Nil];
//    
//}

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



//-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet.tag == 3)
//    {
//        NSLog(@"From didDismissWithButtonIndex - Selected from: %@", [actionSheet buttonTitleAtIndex:buttonIndex]);
//    }
//}
//
//
//-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet.tag == 3)
//    {
//        NSLog(@"From willDismissWithButtonIndex - Selected from: %@", [actionSheet buttonTitleAtIndex:buttonIndex]);
//    }
//}
    
- (IBAction)folderRightBarButtonAction:(UIBarButtonItem *)sender
{
    
}
- (IBAction)saveFolderButoonAction:(UIButton *)sender
{
    folder1=_folderNameTextField.text;
    title1=_fileNameTextField.text;
    text1=_textViewField.text;
    
    NSMutableString *mutableString=[[NSMutableString alloc]init];
    BOOL goodToGo=YES;
    if (folder1.length==0)
    {
        goodToGo=NO;
        [mutableString appendString:@"Folder name is required\n"];
    }
    
    if (title1.length==0)
    {
         goodToGo=NO;
         [mutableString appendString:@"File name is required\n"];
    }
        if(text1.length==0)
    {
         goodToGo=NO;
         [mutableString appendString:@"Enter the text"];
    }
    
    
    if (goodToGo)
    {
    
         [self localData];
        
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Successfully !!" message:@"Your note save successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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

    
   
}

-(void)localData
{
  
    bModel=[[FolderModelData alloc]init];
    bModel.folderName=folder1;
    bModel.titleName=title1;
    bModel.textName=text1;
    
    [tabArray addObject:bModel];
    
    
    AppDelegate *appDel = [UIApplication sharedApplication].delegate;
    appDel.allNotes = tabArray;
    
}

//Alert button action delegate method
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
// 
//    
//[self.navigationController popViewControllerAnimated:YES];
//
//    
//}
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
@end
