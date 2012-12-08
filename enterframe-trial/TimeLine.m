//
//  TimeLine.m
//  enterframe-trial
//
//  Created by FukuiTakeshi on 2012/12/7.
//  Copyright (c) 2012年 f.retu. All rights reserved.
//

#import "TimeLine.h"

/** デフォルトインターバル　*/
const NSTimeInterval DEFAULT_TIME_LNE_INTERVAL = 1.0;

@interface TimeLine ()
{
    /** FPS */
    NSInteger _fps;
    /** タイマー */
    NSTimer *_timer;
    /** 前回のインターバルイベント開始時間 */
    NSDate *_oldTime;
    /** タイムライン開示時間 */
    NSDate *_startTime;
}
@end

/**
 * タイムラインの実装クラスです。
 */
@implementation TimeLine

- (id)initWithFps:(NSInteger)fps
{
    self = [super init];
    if(!self){
        return self;
    }
    self.delegate = nil;
    _fps = fps;
    _interval = DEFAULT_TIME_LNE_INTERVAL;
    
    return self;
}

- (void)dealloc
{
    [_oldTime release];
    [_startTime release];
    
    [super dealloc];
}

- (void)start
{
    _startTime = [[NSDate dateWithTimeIntervalSinceNow:0.0] retain];
    _oldTime = [[NSDate dateWithTimeIntervalSinceNow:0.0] retain];
    _playing = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / _fps
                target:self selector:@selector($_tick:) userInfo:nil repeats:YES];
}

- (void)stop
{
    _playing = NO;
    _oldTime = nil;
    _startTime = nil;
    _frame = 0;
    [_timer invalidate];
}

- (NSTimeInterval)startIntervalSinceDate
{
    return [[NSDate dateWithTimeIntervalSinceNow:0.0] timeIntervalSinceDate:_startTime];
}

#pragma mark --private method
/**
 * FPSに沿って周期的に実行される処理です。
 */
- (void)$_tick:(id)sender
{
    if (_timer.isValid == NO) {
        return;
    }
    
    _frame++;
    
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0.0];
	NSTimeInterval since = [now timeIntervalSinceDate:_oldTime];
    
	if (self.interval <= since) {
        // 指定の間隔以上の経過の場合
        [self.delegate onInterval];
		_frame = 0;
		_oldTime = [[NSDate dateWithTimeIntervalSinceNow:0.0] retain];
	}
    
	[self.delegate onEnterFrame];
}

@end
