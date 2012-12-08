//
//  ViewController.m
//  enterframe-trial
//
//  Created by FukuiReTu on 2012/12/08.
//  Copyright (c) 2012年 f.retu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    TimeLine *_tl;
    IBOutlet UILabel *_fpsLabel;
}

- (IBAction)onClickStart:(id)sender;
- (IBAction)onClickStop:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self == NO) {
        return self;
    }
    
    [self $_init];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == NO) {
        return self;
    }
    
    [self $_init];
    
    return self;
}

#pragma mark -- private method
/**
 * 初期化処理を行います。
 */
- (void)$_init
{
    _tl = [[TimeLine alloc] initWithFps:60];
    _tl.interval = 1.5;
    _tl.delegate = self;
}

#pragma mark -- private method
/**
 * startボタン押下後のイベントです。
 */
- (void)onClickStart:(id)sender
{
   [_tl start]; 
}

#pragma mark -- private method
/**
 * stopボタン押下後のイベントです。
 */
- (void)onClickStop:(id)sender
{
    [_tl stop];
}

#pragma mark --override method dependency TimeLineDelegate
- (void)onEnterFrame
{
    NSLog(@"onEnterFrame executed");
    NSLog(@"frameCount:%d", _tl.frame);
}

#pragma mark --override method dependency TimeLineDelegate
- (void)onInterval
{
    NSLog(@"onInterval executed");
    _fpsLabel.text = [NSString stringWithFormat:@"%.0f%@", _tl.frame / 1.5, @"FPS"];
}

@end
