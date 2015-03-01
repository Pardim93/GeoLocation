//
//  ViewController.m
//  DesafioMapa
//
//  Created by Wellington Pardim Ferreira on 2/26/15.
//  Copyright (c) 2015 Wellington Pardim Ferreira. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>



@interface ViewController ()

@end

@implementation ViewController
NSArray const *pri;
CLLocation const *MyFirstConstant;
CLLocation *crnLoc;
int boo = -1;
MKPointAnnotation *pm;

MKPointAnnotation *you ;

- (IBAction)distancia:(id)sender {
   
    MyFirstConstant = crnLoc;
    
   MKPointAnnotation *pm = [[MKPointAnnotation alloc]init];
   
    pm.coordinate = MyFirstConstant.coordinate;
    [_Mapa addAnnotation:pm];

}

@synthesize locationManager, latitude, longitude, Velocidade, altitude;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc]init]; // inic.. locationManager
    
    locationManager.delegate = self;
   
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){ [self.locationManager requestAlwaysAuthorization];
    }
    
  
    you = [[MKPointAnnotation alloc]init];

    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    
    [locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Um erro foi encontrado" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [errorAlert show];
    
    NSLog(@"Erro: %@",error.description);
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    

    
    
    crnLoc = [locations lastObject];
  

    you.coordinate = crnLoc.coordinate;
    [_Mapa addAnnotation:you];
    NSLog(@"%f",[crnLoc distanceFromLocation:MyFirstConstant]);
    
    _lol.text = [NSString stringWithFormat:@"%.2f",[crnLoc distanceFromLocation:MyFirstConstant]];

    latitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    
    longitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    
    altitude.text = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
    
    Velocidade.text = [NSString stringWithFormat:@"%.2f m",crnLoc.speed];
    CLLocationCoordinate2D loc = [[locations lastObject] coordinate]; 
   
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);

    //Mudar a região atual para visualização de forma animada
    [_Mapa setRegion:region animated:YES ];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}




@end
