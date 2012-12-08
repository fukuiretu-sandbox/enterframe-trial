//
//  TimeLine.h
//  enterframe-trial
//
//  Created by FukuiTakeshi on 2012/12/7.
//  Copyright (c) 2012年 f.retu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeLineDelegate;

/**
 * タイムラインのインターフェースです。
 */
@interface TimeLine : NSObject

/** デリゲートクラス */
@property (assign, nonatomic) id<TimeLineDelegate> delegate;
/** 現在のフレーム数 */
@property (readonly) NSInteger frame;
/** 間隔 */
@property NSTimeInterval interval;
/** タイマーが動いてるかどうか */
@property (readonly) BOOL playing;

/**
 * 初期化を行います。
 *
 * @param fps FPS
 * @return 自身のオブジェクト
 */
- (id)initWithFps:(NSInteger)fps;

/**
 * タイムラインを開始します。
 */
- (void)start;

/**
 * タイムラインを停止します。
 */
- (void)stop;

/**
 * タイムライン開始からの経過時間を返します。
 *
 * @return 開始からの経過時間
 */
- (NSTimeInterval) startIntervalSinceDate;

@end

/**
 * タイムライン処理のデリゲートプロトコルです。
 */
@protocol TimeLineDelegate <NSObject>

/**
 * フレームが再生される度に実行されるイベントです。
 * フレームレートはfpsプロパティで調整してください。
 */
- (void)onEnterFrame;

/**
 * 指定の間隔毎に実行されるイベントです。
 * デフォルトは1.0secです。
 * 実行間隔をデフォルトから変更したい場合はintervalプロパティで調整してください。
 */
- (void)onInterval;

@end
