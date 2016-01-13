//
//  PopViewController.h
//  VNote
//
//  Created by Purushottam Kumar on 12/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popViewControllerDelegate <NSObject>

-(void)logOutAction;

@end



@interface PopViewController : UIViewController

@property(nonatomic,strong)id<popViewControllerDelegate>delegate;




@end
