//
//  ViewController.m
//  DesafioMapa
//
//  Created by Wellington Pardim Ferreira on 2/26/15.
//  Copyright (c) 2015 Wellington Pardim Ferreira. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Social/Social.h>



@interface ViewController ()

@end

@implementation ViewController
NSArray const *pri;
CLLocation const *MyFirstConstant;
CLLocation *crnLoc;
int boo = -1;
MKPointAnnotation *pm, *E, *W , *N, *S;


MKPointAnnotation *you ;
- (IBAction)getRight:(id)sender {

    you.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude , you.coordinate.longitude +  0.00010);
    [self.Mapa  setCenterCoordinate:you.coordinate animated:YES];
}

- (IBAction)getDown:(id)sender {

    you.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude +  0.00010 , you.coordinate.longitude );
    [self.Mapa  setCenterCoordinate:you.coordinate animated:YES];

}

- (IBAction)getLeft:(id)sender {
    
    you.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude , you.coordinate.longitude -  0.00010);
    [self.Mapa  setCenterCoordinate:you.coordinate animated:YES];

}


- (IBAction)getUp:(id)sender {
   
    
    you.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude +  0.00010 , you.coordinate.longitude );
    [self.Mapa  setCenterCoordinate:you.coordinate animated:YES];


    
}

- (IBAction)distancia:(id)sender {
   // CLLocation *youLocation;
  //  youLocation = you.;
    MyFirstConstant = crnLoc;
    NSLog(@"%d",(int)zoomMap.value);

   MKPointAnnotation *pm = [[MKPointAnnotation alloc]init];
   
    pm.coordinate = MyFirstConstant.coordinate;
    [pm setTitle:@"Ponto de Partida"];
    [_Mapa addAnnotation:pm];

}

@synthesize locationManager, latitude, longitude, Velocidade, altitude, zoomMap;

- (IBAction)setPlace:(id)sender { //action responsavel por fazer um lugar escolhido
   UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Definição de lugar"
    message:@"Você deseja marcar esse lugar?"preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* sim = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        //   E.coordinate = crnLoc.coordinate;
          //  int p = crnLoc.coordinate.longitude;
     
            
            
            E.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude , you.coordinate.longitude + 0.00050);
            W.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude , you.coordinate.longitude - 0.00050);
            S.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude - 0.00050, you.coordinate.longitude );
            N.coordinate = CLLocationCoordinate2DMake(you.coordinate.latitude + 0.00050, you.coordinate.longitude );
        
            
            
            [_Mapa addAnnotation:E];
            [_Mapa addAnnotation:W];
            [_Mapa addAnnotation:S];
            [_Mapa addAnnotation:N];
            
            
          
        }];
    
    
    
    
    UIAlertAction* nao = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              }];
    
    [alert addAction:sim];
    [alert addAction:nao];
    [self presentViewController:alert animated:YES completion:nil];

   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.Mapa.showsUserLocation = YES;
   
    self.view.backgroundColor = [UIColor blueColor];
   
    
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc]init]; // inic.. locationManager
    
    locationManager.delegate = self;
   
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){ [self.locationManager requestAlwaysAuthorization];
    }
    
  
    E = [[MKPointAnnotation alloc]init];
    W = [[MKPointAnnotation alloc]init];
    N = [[MKPointAnnotation alloc]init];
    S = [[MKPointAnnotation alloc]init];
    
    
   you = [[MKPointAnnotation alloc]init];
    [you setTitle:@"Eu"];

    
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
   // crnLoc.coordinate.longitude = you.coordinate.longitude;
   
    [_Mapa addAnnotation:you];
  //  NSLog(@"%f",[crnLoc distanceFromLocation:MyFirstConstant]);
    
    _lol.text = [NSString stringWithFormat:@"%.2f",[crnLoc distanceFromLocation:MyFirstConstant]];

    latitude.text   = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    
    longitude.text  = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    
    altitude.text   = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
    
    Velocidade.text = [NSString stringWithFormat:@"%.2f m",crnLoc.speed];
    
    CLLocationCoordinate2D loc = [[locations lastObject] coordinate]; 
   
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc,zoomMap.value, zoomMap.value);

    //Mudar a região atual para visualização de forma animada
    
    [_Mapa setRegion:region animated:YES ];
    if(you.coordinate.longitude >= W.coordinate.longitude && you.coordinate.longitude <= E.coordinate.longitude && you.coordinate.latitude >= S.coordinate.latitude && you.coordinate.latitude <= N.coordinate.latitude){
        
        UIAlertController* chegou = [UIAlertController alertControllerWithTitle:@"Você chegou em seu lugar"
                                                                       message:@"Você deseja compartilhar esse lugar?"preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction* nao1 = [UIAlertAction actionWithTitle:@"Não" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
                                                    }];
        
        UIAlertAction* sim1 = [UIAlertAction actionWithTitle:@"Sim" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         
                                                         if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
                                                         {
                                                             SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                                             [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
                                                             [self presentViewController:tweetSheet animated:YES completion:nil];
                                                         }
                                                         else
                                                         {
                                                              UIAlertView *alertView = [[UIAlertView alloc]
                                                                                       initWithTitle:@"Sorry"
                                                                                       message:@"You can't send a tweet right now, make sure  your device has an internet connection and you haveat least one Twitter account setup"
                                                                                       delegate:self                                              
                                                                                       cancelButtonTitle:@"OK"                                                   
                                                                                       otherButtonTitles:nil];
                                                             [alertView show];
                                                         }
             
                                                     }];
        
        
        [chegou addAction:sim1];
        [chegou addAction:nao1];
        
        [self presentViewController:chegou animated:YES completion:nil];


        
        
        //NSLog(@"Chegou");
    }
    
    
  // [manager stopUpdatingLocation];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}




@end
