//
//  AppDelegate.h
//  JsonComoBBDD
//
//  Created by LLBER on 21/03/13.
//  Copyright (c) 2013 LLBER. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustomDetailViewController.h"
@interface CustomTableViewController ()

@end

@implementation CustomTableViewController


-(void)viewDidAppear:(BOOL)animated {
    [_myTableView reloadData];
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	listOfItems = [[NSMutableArray alloc] init];
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/proyectos.json", documents];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(data == NULL){
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"proyectos" ofType:@"json"]];
    }
    
    NSError *error;
    _json = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]];
    NSDictionary *principal = (NSDictionary *)(_json)[@"proyectos"];
    NSLog(@"json leido %i",[principal[@"listados"]count ]);
    for (NSInteger i=0; i<[principal[@"listados"] count]; i++) {
        [listOfItems addObject:[principal[@"listados"] objectAtIndex:i]];
    }
	//Colocar Titulo
	self.navigationItem.title=@"Proyectos";

}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
		return [listOfItems count];
}

// Personalizar las secciones
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
		NSDictionary *dictionary = [listOfItems objectAtIndex:section];
		NSArray *array = [dictionary objectForKey:@"tareas"];
		return [array count];
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    NSString *titleProject;
    for (NSInteger i=0; i<[dictionary count]; i++){
        if (section==i) {
            titleProject=[NSString stringWithFormat:@"%@ - tareas:%@",[dictionary objectForKey:@"nombreProyecto"],[dictionary objectForKey:@"numeroTareas"]];
        }
    }
    return titleProject;
}

// Personalizar apariencia de las celdas

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"myCellView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //leemos el json
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    //tomamos el array actual que esta reflejado por la seccion activa del uitableview
    NSArray *array = [dictionary objectForKey:@"tareas"];
	//cargamos los valores con los datos del item actual
    NSString *cellValue = [[array objectAtIndex:indexPath.row] objectForKey:@"nombreTarea"];
    
    cell.textLabel.text = cellValue;
    cell.detailTextLabel.text=[[array objectAtIndex:indexPath.row] objectForKey:@"descTarea"];
    if ([[[array objectAtIndex:indexPath.row] objectForKey:@"estadoTarea"] boolValue]) {
        cell.textLabel.textColor=[UIColor greenColor];
    }
    else{
        cell.textLabel.textColor=[UIColor redColor];
    }
	
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
} 


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToDetail"]) {
        CustomDetailViewController * detalle = [segue destinationViewController];
        NSDictionary *dictionary = [listOfItems objectAtIndex:_myTableView.indexPathForSelectedRow.section];
		NSArray *array = [dictionary objectForKey:@"tareas"];
        detalle.detail=[array objectAtIndex:_myTableView.indexPathForSelectedRow.row];
        detalle.detailJson=_json;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
