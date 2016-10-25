//
//  ShowSoFuckingGreatImageViewController.m
//  SoURSoFuckingGreat
//
//  Created by Wolf on 16/10/25.
//  Copyright © 2016年 Wolf. All rights reserved.
//

#import "ShowSoFuckingGreatImageViewController.h"

@interface ShowSoFuckingGreatImageViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *soFuckingGreatImageView;

@end

@implementation ShowSoFuckingGreatImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.soFuckingGreatImageView.image = _soFuckingGreatImage;
}

- (IBAction)saveImage:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.soFuckingGreatImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FUCKING GREAT SAVING" message:error==nil?@"SUCCESS":@"ERROR" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *No = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:No];
    [self presentViewController:alert animated:TRUE completion:nil];
}


@end
