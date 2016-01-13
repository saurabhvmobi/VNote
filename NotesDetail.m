//
//  NotesDetail.m
//  VNote
//
//  Created by Purushottam Kumar on 08/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "NotesDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "FolderModelData.h"
#import "HomePage.h"
#import "FileModelData.h"
#import "AppDelegate.h"
#import "NoteTableViewCell.h"
#import "FileViewController.h"
#import "NotesDescriptionViewController.h"


@interface NotesDetail ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImage *myImage;
    NSMutableArray *tabArray;
    NSIndexPath *indexpath;
    AppDelegate *appDel;
    UIImage *image1;


}
@property (weak, nonatomic) IBOutlet UIView *myLabelView;
- (IBAction)notesBackButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableFileView;

- (IBAction)addFileButtonClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *folderNameLabel;
@property (weak, nonatomic) IBOutlet UIView *tapToCreateAgain;

@end

@implementation NotesDetail

- (void)viewDidLoad {
   
     [super viewDidLoad];
    
    
    //Hide table view
    //self.myTableFileView.hidden=YES;
    
   
        _fileModel = [[FileModelData alloc]init];
        _fileModel.titleName= _nModel.titleName;
    _fileModel.texTName=_nModel.textName;
    _fileModel.foldername=_nModel.folderName;
    
    //Gardient color use in background color
    UIColor *darkColor=[UIColor colorWithRed:0.21 green:0.17 blue:0.13 alpha:1.00];
    UIColor *lightColor=[UIColor colorWithRed:0.21 green:0.23 blue:0.23 alpha:1.00];
    
    CAGradientLayer *gardient=[CAGradientLayer layer];
    
    gardient.colors=[NSArray arrayWithObjects:(id)darkColor.CGColor,(id)lightColor.CGColor, nil];
    gardient.frame=self.view.bounds;
    [self.view.layer insertSublayer:gardient atIndex:0];
    
     //Set the corner of the view
    _myLabelView.layer.cornerRadius=5;
    _myLabelView.layer.borderWidth=1;
    
    //Set the title and color
    self.navigationItem.title=@"Notes";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    //Hide backBar Button
     self.navigationItem.hidesBackButton=YES;
    
    
    
//    myImage = [UIImage imageNamed:@"2016-01-06(1)"];
//    UIButton *myButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [myButton1 setImage:myImage forState:UIControlStateNormal];
//    
//    // myButton.showsTouchWhenHighlighted = YES;
//    myButton1.frame = CGRectMake(0.0, 0.0, myImage.size.width, myImage.size.height);
//    
//    [myButton1 addTarget:self action:@selector(tapp) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithCustomView:myButton1];
//    self.navigationItem.rightBarButtonItem = leftButton1;
//
    
    
    
    
    myImage = [UIImage imageNamed:@"direction196"];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setImage:myImage forState:UIControlStateNormal];
    
    // myButton.showsTouchWhenHighlighted = YES;
    myButton.frame = CGRectMake(10.0, 0.0,24, 24);
    
[myButton addTarget:self action:@selector(tapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = leftButton;
   
     tabArray=[[NSMutableArray alloc]init];
    
     appDel = [UIApplication sharedApplication].delegate;
   
    if (appDel.allfile == nil)
    {
        tabArray=[[NSMutableArray alloc]init];
        [appDel.allfile addObject:_fileModel];
    
    }else{
        
         [appDel.allfile addObject:_fileModel];
    }
    
    tabArray = appDel.allfile;
    
    
    
    
    
    
   
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _folderNameLabel.text=_nModel.folderName;
   
    tabArray = appDel.allfile;
    
    
    if ([tabArray count]==0)
    {
        self.myTableFileView.hidden=YES;
    }
    else
    {
        self.tapToCreateAgain.hidden=YES;
    }
    [self.myTableFileView reloadData];


}






- (IBAction)notesBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tapped
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[tabArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"not" forIndexPath:indexPath];
    
   _fileModel = [tabArray objectAtIndex:indexPath.row];
    
       cell.fileNameLabel.text= _fileModel.titleName;
    
     return cell;
}
- (IBAction)addFileButtonClick:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"file" sender:indexpath];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"file"])
    {
    FileViewController *file = segue.destinationViewController;
    file.currentFoldername = self.folderNameLabel.text;
    }
    else
    {
        indexpath=sender;
    NotesDescriptionViewController *notesDesc=segue.destinationViewController;
    notesDesc.descModel=[tabArray objectAtIndex:indexpath.row];

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"notesDesc" sender:indexPath];
}



@end
