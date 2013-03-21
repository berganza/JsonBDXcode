//
//  AppDelegate.h
//  JsonComoBBDD
//
//  Created by LLBER on 21/03/13.
//  Copyright (c) 2013 LLBER. All rights reserved.
//

#import "CustomDetailViewController.h"

@interface CustomDetailViewController ()

@end

@implementation CustomDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _fieldNombreDetail.delegate=self;
	// Do any additional setup after loading the view.
    _fieldNombreDetail.text=[_detail objectForKey:@"nombreTarea"];
    _detailTitle.text=[_detail objectForKey:@"nombreTarea"];
    _imageDetail.image=[UIImage imageNamed:[_detail objectForKey:@"imageTarea" ]];
    _detailDescription.text=[_detail objectForKey:@"descTarea"];
    _detailDescription.textAlignment=NSTextAlignmentCenter ;
    _detailState.text=@"Estado";
    _detailSW.on=[[_detail objectForKey:@"estadoTarea"] boolValue];
    
        
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_fieldNombreDetail resignFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.detail setObject:_fieldNombreDetail.text forKey:@"nombreTarea" ];
    [self.detail setObject:_detailDescription.text forKey:@"descTarea" ];
    [self.detail setObject:[NSNumber numberWithBool:_detailSW.on] forKey:@"estadoTarea" ];
    NSLog(@"json sin modificar %@",self.detail);
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/proyectos.json", documents];
    NSOutputStream *stream = [[NSOutputStream alloc] initToFileAtPath:path append:NO];
    [stream open];

    NSError *writeError = nil;
    NSInteger bytesWritten = [NSJSONSerialization writeJSONObject:self.detailJson toStream:stream options:NSJSONWritingPrettyPrinted error:&writeError];
    if (bytesWritten <= 0) {
        NSLog(@"Error writing JSON Data");
    }
    NSLog(@"json modificado %@",self.detailJson);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionNombreField:(id)sender {
    
}
@end
