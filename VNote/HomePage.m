//
//  HomePage.m
//  VNote
//
//  Created by Purushottam Kumar on 06/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "HomePage.h"
#import <QuartzCore/QuartzCore.h>
#import "FolderViewController.h"
#import "FolderModelData.h"
#import "HomePageTableViewCell.h"
#import "AppDelegate.h"
#import "NotesDetail.h"
#import <WYPopoverController/WYPopoverController.h>
#import "PopViewController.h"


@interface HomePage ()<UITableViewDelegate,UITableViewDataSource,WYPopoverControllerDelegate,popViewControllerDelegate>
{
    NSArray *tabArray;
    FolderModelData *cModel;
    NSArray *folderAll;
    NSIndexPath *indexpath;
    WYPopoverController *popOverController;
    UIImage *myImage;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)addNoteButtonAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *tapToCreateNote;
- (IBAction)rightBarButtonAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView1;
@property (weak, nonatomic) IBOutlet UILabel *tapToCreate;

@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UILabel *itsAllAboutNotesLabel;
@property (weak, nonatomic) IBOutlet UIView *tapToCreateView;
- (IBAction)wypPopViewAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *popButton;

@end

@implementation HomePage



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //Navigation hide,title,title color,hide navigation back button
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title=@"Home";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.937 green:0.392 blue:0.392 alpha:1];    self.navigationItem.hidesBackButton=YES;
    
    
    //Gardient color use in background color
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    
     
    
    myImage = [UIImage imageNamed:@"2016-01-06(1)"];
    UIButton *myButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton1 setImage:myImage forState:UIControlStateNormal];
    
    // myButton.showsTouchWhenHighlighted = YES;
    myButton1.frame = CGRectMake(0.0, 0.0, myImage.size.width, myImage.size.height);
    
    [myButton1 addTarget:self action:@selector(tapped :) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton1];
    self.navigationItem.rightBarButtonItem = leftButton;


    //Set the label corner
    _tapToCreateNote.layer.cornerRadius=5;
    _tapToCreateNote.layer.borderWidth=1;
    
    
    _tapToCreate.layer.cornerRadius=5;
    _tapToCreate.layer.borderWidth=1;
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    tabArray = app.allNotes;
    [self.myTableView1 reloadData];
    
    
    if ([tabArray count]==0)
    {
        self.myTableView1.hidden=YES;
        
    }
    else
    {
        
        self.myTableView1.hidden=NO;
        self.tapToCreate.hidden=YES;
        self.noteImage.hidden=YES;
        self.itsAllAboutNotesLabel.hidden=YES;
        self.tapToCreateView.hidden=YES;
    }
    

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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tabArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"hometabelcell" forIndexPath:indexPath];
    cModel=[tabArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=cModel.folderName;
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"notesDetail11" sender:indexPath];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"notesDetail11"])
    {
        indexpath=sender;
        NotesDetail *nt=segue.destinationViewController;
        AppDelegate *appDel=[UIApplication sharedApplication].delegate;
        appDel.allfile=[[NSMutableArray alloc]init];
        FolderModelData *model=appDel.allNotes[indexpath.row];
        NSLog(@"%@,%@,%@",model.folderName,model.titleName,model.textName);
        nt.nModel=[appDel.allNotes objectAtIndex:indexpath.row];
    }
}
- (IBAction)addNoteButtonAction:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"Add" sender:self];
}

- (IBAction)rightBarButtonAction:(UIBarButtonItem *)sender
{
    
}

-(void)tapped:(UIButton*)sender
{
    
    UIView *btn = (UIView *)sender;
    
    if (popOverController == nil)
    {
        PopViewController  *popUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopUpStoryBoardID"];
       
        popUpVC.delegate = self;
        
        CGSize contentSize = CGSizeMake(200,150);
        
        popUpVC.preferredContentSize = contentSize;
        
        
        
        popOverController = [[WYPopoverController alloc] initWithContentViewController:popUpVC];
        popOverController.delegate = self;
        popOverController.passthroughViews = @[btn];
        
        
        //        popOverController.popoverLayoutMargins = UIEdgeInsetsMake(CGFloat top, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        
        popOverController.popoverLayoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
        
        
        popOverController.theme = [WYPopoverTheme themeForIOS7];
        popOverController.theme.outerCornerRadius = 2;
        
        
        popOverController.theme.borderWidth = 2;
        popOverController.theme.outerStrokeColor = [UIColor lightGrayColor];
        
        //        popOverController.theme.innerStrokeColor = [UIColor redColor];
        
        
        popOverController.theme.arrowHeight = 8;
        popOverController.theme.arrowBase= 15;
        popOverController.theme.fillTopColor = [UIColor grayColor];
        popOverController.theme.overlayColor= [UIColor clearColor];
        
        CGRect biggerBounds = CGRectInset(sender.bounds, -6, -6);
        
        [popOverController presentPopoverFromRect:biggerBounds inView:sender permittedArrowDirections:(WYPopoverArrowDirectionUp) animated:YES options:(WYPopoverAnimationOptionFadeWithScale)];
        
        //        [BlurEffect blurredImageOfView:self.view onBaseView:chatSubMenuVC.view withTintColor:[UIColor whiteColor]];
    }else
    {
        [popOverController dismissPopoverAnimated:YES completion:^{
            popOverController.delegate = nil;
            popOverController = nil;
        }];
    }
}
-(BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)popoverController
{
    return YES;
}
-(void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController
{
    popOverController.delegate=nil;
    popOverController=nil;
}


-(void)logOutAction
{
    
    [popOverController dismissPopoverAnimated:NO];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}







@end
