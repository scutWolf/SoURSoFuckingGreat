//
//  GreatDrawingViewController.m
//  SoURSoFuckingGreat
//
//  Created by Wolf on 16/10/21.
//  Copyright © 2016年 Wolf. All rights reserved.
//


#import "GreatDrawingViewController.h"
#import "UIImage+Rotate.h"
#import "ShowSoFuckingGreatImageViewController.h"

@interface GreatDrawingViewController ()
@property (strong,nonatomic) IBOutlet UIImageView *greatArmDrawingImageView;
@property (strong,nonatomic) IBOutlet UIView *greatDrawingConatiner;
@property (assign,nonatomic) CGPoint greatStartPoint;
@property (assign,nonatomic) CGPoint lastPoint;
@property (assign,nonatomic) BOOL isDrawn;
@property (strong,nonatomic) UIImage *greatBodyImage;
@property (strong,nonatomic) UIImage *greatHandImage;
@property (strong,nonatomic) UIImage *greatArmImage;
@property (assign,nonatomic) CGFloat brush;
@end

static const CGRect GREAT_BODY_RECT = {88,57,89,75};
static const CGRect GREAT_HAND_RECT = {5,30,48,39};
static const CGFloat GREAT_BODY_OUT_WIDTH = 20;
static const CGFloat GREAT_HAND_OUT_WIDTH = 13;

@implementation GreatDrawingViewController{
    
    CGPoint lastPointEver;
    BOOL mouseSwiped;
    BOOL rectConfigured;
    CGRect realArmRect;
    int markPointTimes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    brush = GREAT_HAND_OUT_WIDTH;
    [self restart];
}

-(void)restart{
    lastPointEver = {0,0};
    _brush = GREAT_BODY_OUT_WIDTH;
    self.greatArmImage = nil;
//    self.mainGreatImage = nil;
    _lastPoint = CGPointMake(0,0);
    rectConfigured = false;
    _isDrawn = false;
}

- (IBAction)uRSoFuckingGreatButtonPressed:(id)sender {
    if (self.greatArmDrawingImageView.image==nil)
        return ;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FUCKING GREAT" message:@"Please Input Great Text" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"那你他妈很棒哦";
    }];
    UIAlertAction *Great = [UIAlertAction actionWithTitle:@"Great" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *greatTextField = alert.textFields.firstObject;
        [self performSegueWithIdentifier:@"pushToShowSoFuckingGreatImage" sender:[self soURSoFuckingGreatImageWithSoFuckingGreatString:[greatTextField.text isEqualToString:@""]?greatTextField.placeholder:greatTextField.text]];
    }];
    UIAlertAction *No = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:No];
    [alert addAction:Great];
    
    [self presentViewController:alert animated:TRUE completion:nil];
}

-(UIImage *)soURSoFuckingGreatImageWithSoFuckingGreatString:(NSString *)greatString{
    
    BOOL stringEmpty = [greatString isEqualToString:@""]||greatString==nil;
    CGRect greatRect = GetWholeSoFuckingGreatImageRect(realArmRect, self.bodyRect, self.handRect);
    CGSize resultSize = {(greatRect.size.width+40),(greatRect.size.height+(stringEmpty?40.0:120.0))};
    
    UIGraphicsBeginImageContext(resultSize);
    
    [self.greatArmDrawingImageView.image drawInRect:{-greatRect.origin.x+20,-greatRect.origin.y+20,self.greatArmDrawingImageView.image.size}];
    
    if (!stringEmpty){
        CGPoint center = {resultSize.width/2,resultSize.height-50};
        UIFont *font = [UIFont systemFontOfSize:25];
        CGRect textRect = [greatString boundingRectWithSize:CGSizeMake(10000.0f, 10000.0f)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil];
        [greatString drawAtPoint:{center.x-textRect.size.width/2,center.y-textRect.size.height/2} withAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:font}];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - calculate func

inline CGFloat GetMAXFromThreeFloat(CGFloat a,CGFloat b,CGFloat c){
    return MAX(MAX(a,b),c);
}
inline CGFloat GetMINFromThreeFloat(CGFloat a,CGFloat b,CGFloat c){
    return MIN(MIN(a,b),c);
}
inline CGPoint DownRightPointOfRect(CGRect rect){
    return {rect.origin.x+rect.size.width,rect.origin.y+rect.size.height};
}

inline void ConfigureArmRect(CGRect *rect,CGPoint point,BOOL conigured){
    if (!conigured)
        *rect = CGRectMake(point.x, point.y, 0, 0);
    *rect = CGRectMake(MIN(rect->origin.x, point.x),
                       MIN(rect->origin.y,point.y),
                       rect->origin.x>point.x?(rect->size.width+rect->origin.x-point.x) :MAX(point.x-rect->origin.x,rect->size.width),
                       rect->origin.y>point.y?(rect->size.height+rect->origin.y-point.y):MAX(point.y-rect->origin.y,rect->size.height));
}

inline CGRect GetWholeSoFuckingGreatImageRect(CGRect armRect,CGRect bodyRect,CGRect handRect){
    CGFloat x = GetMINFromThreeFloat(armRect.origin.x, bodyRect.origin.x, handRect.origin.x);
    CGFloat y = GetMINFromThreeFloat(armRect.origin.y, bodyRect.origin.y, handRect.origin.y);
    CGFloat width = GetMAXFromThreeFloat(DownRightPointOfRect(armRect).x, DownRightPointOfRect(bodyRect).x,DownRightPointOfRect(handRect).x)-x;
    CGFloat height = GetMAXFromThreeFloat(DownRightPointOfRect(armRect).y, DownRightPointOfRect(bodyRect).y,DownRightPointOfRect(handRect).y)-y;
    return {x,y,width,height};
}


-(CGPoint)handOffsetPoint:(CGSize)newImageSize{
    CGPoint point = CGPointApplyAffineTransform({GREAT_HAND_RECT.origin.x-GREAT_HAND_RECT.size.width/2,GREAT_HAND_RECT.origin.y-GREAT_HAND_RECT.size.height/2}, CGAffineTransformMakeRotation(self.handRotateRadians));
    return {point.x+newImageSize.width/2,point.y+newImageSize.height/2};
}


#pragma mark - getter

-(UIImage *)greatHandImage{
    if(!_greatHandImage)
        _greatHandImage = [UIImage imageNamed:@"GREAT_HAND.jpg"];
    return _greatHandImage;
}

-(UIImage *)greatBodyImage{
    if(!_greatBodyImage)
        _greatBodyImage = [UIImage imageNamed:@"GREAT_BODY.jpg"];
    return _greatBodyImage;
}

-(UIImage *)rotatedHandImage{
    return [self.greatHandImage rotateImageWithRadian: self.handRotateRadians];;
}

-(CGFloat)brush{
    return _brush=MAX(GREAT_HAND_OUT_WIDTH,_brush-0.1);
}

-(CGFloat)handRotateRadians{
    return atan2((_lastPoint.y-lastPointEver.y),(_lastPoint.x-lastPointEver.x));
}

-(void)drawRotatedHand{
    UIImage *rotatedImage = [self.greatHandImage rotateImageWithRadian: self.handRotateRadians];
    [rotatedImage drawInRect:self.handRect];
}

-(CGRect)bodyRect{
    return {_greatStartPoint.x-GREAT_BODY_RECT.origin.x,_greatStartPoint.y-GREAT_BODY_RECT.origin.y,GREAT_BODY_RECT.size};
}

-(CGRect)handRect{
    UIImage *rotatedImage = self.rotatedHandImage;
    return {_lastPoint.x-[self handOffsetPoint:rotatedImage.size].x,_lastPoint.y-[self handOffsetPoint:rotatedImage.size].y,rotatedImage.size};
}

#pragma mark - setter

-(void)setGreatStartPoint:(CGPoint)greatStartPoint{
    if (!_isDrawn){
        _greatStartPoint = greatStartPoint;
        _isDrawn = !_isDrawn;
    }
}

-(void)setGreatArmImage:(UIImage *)greatArmImage{
    if(!(_greatArmImage = greatArmImage)){
        self.greatArmDrawingImageView.image = nil;
        return ;
    }

    UIGraphicsBeginImageContext(self.greatDrawingConatiner.frame.size);
    [self.greatBodyImage drawInRect:self.bodyRect];
    [self drawRotatedHand];
    [_greatArmImage drawInRect:CGRectMake(0, 0, self.greatDrawingConatiner.frame.size.width, self.greatDrawingConatiner.frame.size.height)];
    
    self.greatArmDrawingImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //    [self.tempGreatDrawImageView setAlpha:opacity];
    UIGraphicsEndImageContext();
    

}


-(void)setLastPoint:(CGPoint)lastPoint{
    if(realArmRect.size.width<100 || ((fabs(lastPoint.x-lastPointEver.x)+fabs(lastPoint.y-lastPointEver.y)>10) && (markPointTimes++>10))){
        lastPointEver = _lastPoint;
        markPointTimes = 0;
    }
    _lastPoint = lastPoint;
    ConfigureArmRect(&realArmRect, lastPoint, rectConfigured);
    if (!rectConfigured)
        rectConfigured = true;
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self restart];
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    if (touch.view != self.greatDrawingConatiner)
        return;
    
    self.lastPoint = [touch locationInView:self.greatDrawingConatiner];
    self.greatStartPoint = self.lastPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    if (touch.view != self.greatDrawingConatiner)
        return;
    CGPoint currentPoint = [touch locationInView:self.greatDrawingConatiner];
    
    UIGraphicsBeginImageContext(self.greatDrawingConatiner.frame.size);
    [self.greatArmImage drawInRect:CGRectMake(0, 0, self.greatDrawingConatiner.frame.size.width, self.greatDrawingConatiner.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.greatArmImage = UIGraphicsGetImageFromCurrentImageContext();
//    [self.tempGreatDrawImageView setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (((UITouch *)[touches anyObject]).view != self.greatDrawingConatiner)
        return;
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.greatDrawingConatiner.frame.size);
        [self.greatArmImage drawInRect:CGRectMake(0, 0, self.greatDrawingConatiner.frame.size.width, self.greatDrawingConatiner.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),  0, 0, 0, 1);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.greatArmImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[ShowSoFuckingGreatImageViewController class]]){
        ShowSoFuckingGreatImageViewController* des = (ShowSoFuckingGreatImageViewController*)segue.destinationViewController;
        des.soFuckingGreatImage = (UIImage *)sender;
    }
}

@end
