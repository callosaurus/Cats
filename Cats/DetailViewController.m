//
//  DetailViewController.m
//  Cats
//
//  Created by Callum Davies on 2017-02-28.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.photo.photoTitle;
    self.detailImageView.image = self.photo.photoImage;
    
    NSString *photoString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=9b2069a2104b7db539c5b64982653c8d&photo_id=%@&format=json&nojsoncallback=1", self.photo.idNumber];
    
    //set up URL - TO BE ENCAPSULATED WITH NETWORK MANAGER etc
    NSURL *url = [NSURL URLWithString:photoString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask2 = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *JSONstep1 = [parsedJSON valueForKey:@"photo"];
        NSDictionary *JSONstep2 = [JSONstep1 valueForKey:@"location"];
        NSNumber *latitudeNumber = [JSONstep2 valueForKey:@"latitude"];
        NSNumber *longitudeNumber = [JSONstep2 valueForKey:@"longitude"];
        NSLog(@"LATITUDE: %@, LONGITUDE: %@",latitudeNumber, longitudeNumber);
        
        
        self.photo.coordinate = CLLocationCoordinate2DMake([latitudeNumber doubleValue], [longitudeNumber doubleValue]);
        
        [self setMapView];
        
    }];
    
    [dataTask2 resume];
    
}

- (void) setMapView
{
    MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
    self.mapView.region = MKCoordinateRegionMake(self.photo.coordinate, span);
    
    [self.mapView addAnnotation:self.photo];
}


@end
