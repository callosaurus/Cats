//
//  ViewController.m
//  Cats
//
//  Created by Callum Davies on 2017-02-27.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "Photo.h"
#import "DetailViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSMutableArray *catPhotoObjectsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize
    self.catPhotoObjectsArray = [[NSMutableArray alloc] init];;
    
    //fetch cat JSON from flickr
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=9b2069a2104b7db539c5b64982653c8d&tags=cats&has_geo=&extras=url_m&format=json"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSDictionary *JSONstep1 = [parsedJSON valueForKey:@"photos"];
            NSArray *arrayOfPhotoDictionaries = [JSONstep1 valueForKey:@"photo"];
            
            for (NSDictionary *catPhotoDictionary in arrayOfPhotoDictionaries) {
                Photo *newCatPhoto = [[Photo alloc] initWithTitle:[catPhotoDictionary valueForKey:@"title"]
                                                         IDNumber:[catPhotoDictionary valueForKey:@"id"]
                                                           andURL:[catPhotoDictionary valueForKey:@"url_m"]];
                
                [self.catPhotoObjectsArray addObject:newCatPhoto];
            }
            
            [self.collectionView reloadData];
            
        }];
    }];
    
    [dataTask resume];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.catPhotoObjectsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.photo = self.catPhotoObjectsArray[indexPath.item];
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"moreDetail" sender:self];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PhotoCell *)sender
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC = segue.destinationViewController;
    Photo *newPhoto = sender.photo;
    detailVC.photo = newPhoto;
}

@end
