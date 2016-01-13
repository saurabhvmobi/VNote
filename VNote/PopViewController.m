//
//  PopViewController.m
//  VNote
//
//  Created by Purushottam Kumar on 12/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "PopViewController.h"
#import "PopTableViewCell.h"
#import "PopModelData.h"
#import <UIKit/UIKit.h>

@interface PopViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tabArray;
    PopModelData *aModel;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *myView;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    tabImageArray=[[NSArray alloc]init];
//    tabImageArray=@[@"rubbish12",@"edit46",@"arrow491",@"square236 (1)"];
    
//    tabArray=[[NSArray alloc]init];
//    tabArray=@[@"Delete",@"Edit",@"Change Password",@"Log Out"];
    
    
    tabArray=[[NSMutableArray alloc]init];
    
    
    _myTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    _myTableView.layer.cornerRadius=5;
    _myTableView.layer.borderWidth=1;
    
    _myView.layer.cornerRadius=5;
    _myView.layer.borderWidth=1;
    
    
    [self localData];
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
    PopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"popCell" forIndexPath:indexPath];
    aModel=[tabArray objectAtIndex:indexPath.row];
    cell.popNameLabel.text=aModel.nameList;
    cell.popCellImage.image=aModel.imageList;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==3)
    {
        [self.delegate logOutAction];
    }
    else if(indexPath.row==1)
    {
    }
    
    
}
-(void)localData
{
    aModel=[[PopModelData alloc]init];
    aModel.nameList=@"Delete";
    aModel.imageList=[UIImage imageNamed:@"rubbish12 (1)"];
    [tabArray addObject:aModel];
    
    aModel=[[PopModelData alloc]init];
    aModel.nameList=@"Edit";
    aModel.imageList=[UIImage imageNamed:@"edit46 (1)"];
    [tabArray addObject:aModel];
    
    aModel=[[PopModelData alloc]init];
    aModel.nameList=@"Change Password";
    aModel.imageList=[UIImage imageNamed:@"arrow491 (1)"];
    [tabArray addObject:aModel];
    
    aModel=[[PopModelData alloc]init];
    aModel.nameList=@"Log Out";
    aModel.imageList=[UIImage imageNamed:@"square236 (2)"];
    [tabArray addObject:aModel];
    

    
}

@end
