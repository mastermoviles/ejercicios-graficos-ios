//
//  S7GraphView.h
//  S7Touch
//
//  Created by Aleks Nesterow on 9/27/09.
//  aleks.nesterow@gmail.com
//  
//  Thanks to http://snobit.habrahabr.ru/ for releasing sources for his
//  Cocoa component named GraphView.
//  
//  Copyright © 2009, 7touchGroup, Inc.
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  * Neither the name of the 7touchGroup, Inc. nor the
//  names of its contributors may be used to endorse or promote products
//  derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY 7touchGroup, Inc. "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL 7touchGroup, Inc. BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//  

#import <UIKit/UIKit.h>
#import "S7Macros.h"

@class S7GraphView;

@protocol S7GraphViewDataSource<NSObject>

@required

/** 
  * Returns the number of plots your want to be rendered in the view.
  * 
  * @params
  * graphView Component that is asking for the number of plots.
  * 
  * @return Number of plots your want to be rendered in the view.
  */
- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView;

/** 
  * Returns an array with objects of any type you can provide a formatter for via xValueFormatter property
  * or stay happy with default formatting.
  * 
  * @params
  * graphView Component that is asking for the values.
  * 
  * @return Array with objects of any type you can provide a formatter for via xValueFormatter property
  * or stay happy with default formatting.
  */
- (NSArray *)graphViewXValues:(S7GraphView *)graphView;

/** 
  * Returns an array with objects of type NSNumber.
  * 
  * @params
  * graphView Component that is asking for the values.
  * plotIndex Index of the plot that you should provide an array of values for.
  * 
  * @return Array with objects of type NSNumber.
  */
- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex;

/** 
 * Returns a string with the legend for a given plot.
 * 
 * @params
 * graphView Component that is asking for the values.
 * plotIndex Index of the plot that you should provide the legend for.
 * 
 * @return Array with objects of type NSNumber.
 */
- (NSString *)graphView:(S7GraphView *)graphView legendForPlot:(NSUInteger)plotIndex;

@optional

/** 
  * Returns the value indicating whether the component should render the plot with the specified index as filled.
  *
  * @param
  * graphView Component that is asking whether the plot should be filled.
  * plotIndex Index of the plot that you should decide whether it is filled or not.
  * 
  * @return YES if the plot should be rendered as filled; otherwise, NO.
  */
- (BOOL)graphView:(S7GraphView *)graphView shouldFillPlot:(NSUInteger)plotIndex;

@end

@interface S7GraphView : UIView

/** Returns a different color for the first 10 plots. */
+ (UIColor *)colorByIndex:(NSInteger)index;

@property (nonatomic, unsafe_unretained) IBOutlet id<S7GraphViewDataSource> dataSource;

@property (nonatomic, strong) IBOutlet NSFormatter *xValuesFormatter;
@property (nonatomic, strong) IBOutlet NSFormatter *yValuesFormatter;

@property (nonatomic, assign) BOOL drawAxisX;
@property (nonatomic, assign) BOOL drawAxisY;
@property (nonatomic, assign) BOOL drawGridX;
@property (nonatomic, assign) BOOL drawGridY;

@property (nonatomic, strong) UIColor *xValuesColor;
@property (nonatomic, strong) UIColor *yValuesColor;

@property (nonatomic, strong) UIColor *gridXColor;
@property (nonatomic, strong) UIColor *gridYColor;

@property (nonatomic, assign) BOOL drawInfo;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, strong) UIColor *infoColor;

- (void)reloadData;

@end
