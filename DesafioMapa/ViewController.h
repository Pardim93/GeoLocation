//
//  ViewController.h
//  DesafioMapa
//
//  Created by Wellington Pardim Ferreira on 2/26/15.
//  Copyright (c) 2015 Wellington Pardim Ferreira. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface ViewController : UIViewController{
    IBOutlet UILabel *latitude;
    
    IBOutlet UILabel *longitude;
    
    IBOutlet UILabel *altitude;

    __weak IBOutlet UIStepper *maisMenos;
}

@property (weak, nonatomic) IBOutlet UIStepper *zoomMap;

@property (retain) IBOutlet MKMapView *Mapa;

@property (retain) CLLocationManager *locationManager;


@property (weak, nonatomic) IBOutlet UILabel *Velocidade;

@property (weak, nonatomic) IBOutlet UILabel *lol;

@property UILabel *latitude, *longitude, *altitude;

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end

