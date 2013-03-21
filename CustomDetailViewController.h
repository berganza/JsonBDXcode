//
//  AppDelegate.h
//  JsonComoBBDD
//
//  Created by LLBER on 21/03/13.
//  Copyright (c) 2013 LLBER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDetailViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (nonatomic,strong) id detail;
@property (nonatomic,strong) NSMutableDictionary* detailJson;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;
@property (weak, nonatomic) IBOutlet UILabel *detailState;
@property (weak, nonatomic) IBOutlet UISwitch *detailSW;

@property (weak, nonatomic) IBOutlet UITextField *fieldNombreDetail;


@end
