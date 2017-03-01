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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.photo.photoTitle;
    self.detailImageView.image = self.photo.photoImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
