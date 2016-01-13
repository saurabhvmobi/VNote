//
//  NotesDetail.h
//  VNote
//
//  Created by Purushottam Kumar on 08/01/16.
//  Copyright © 2016 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FolderModelData.h"
#import "FileModelData.h"

@interface NotesDetail : UIViewController
@property(strong,nonatomic)FolderModelData *nModel;
@property(strong,nonatomic)FileModelData *fileModel;
@end
