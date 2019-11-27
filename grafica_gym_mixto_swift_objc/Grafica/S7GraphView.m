//
//  S7GraphView.m
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

#import "S7GraphView.h"

@interface S7GraphView (PrivateMethods)

- (void)initializeComponent;

@end

@implementation S7GraphView

+ (UIColor *)colorByIndex:(NSInteger)index {
	
	UIColor *color;
	
	switch (index) {
		case 0: color = RGB(5, 141, 191);
			break;
		case 1: color = RGB(80, 180, 50);
			break;		
		case 2: color = RGB(255, 102, 0);
			break;
		case 3: color = RGB(255, 158, 1);
			break;
		case 4: color = RGB(252, 210, 2);
			break;
		case 5: color = RGB(248, 255, 1);
			break;
		case 6: color = RGB(176, 222, 9);
			break;
		case 7: color = RGB(106, 249, 196);
			break;
		case 8: color = RGB(178, 222, 255);
			break;
		case 9: color = RGB(4, 210, 21);
			break;
		default: color = RGB(204, 204, 204);
			break;
	}
	
	return color;
}


- (instancetype)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		[self initializeComponent];
    }
	
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
	
	if (self = [super initWithCoder:decoder]) {
		[self initializeComponent];
	}
	
	return self;
}
 

- (void)drawRect:(CGRect)rect {
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
	CGContextFillRect(c, rect);
	
    // TODO (d) Dibujar gradiente de fondo
    // 1. Definir 2 locations (0, 1) con colores (0.1, 0.1, 0.1, 1.0) y (0.4, 0.4, 0.4, 1.0)
    // 2. Crear espacio de color (CGColorSpaceRef) de tipo DeviceRGB 
    // 3. Crear gradiente (CGGradientRef) con los componentes anteriores
    // 4. Dibujar gradiente lineal desde (0,0) hasta (0, self.frame.size.height)
    
    /// ...
    
	NSUInteger numberOfPlots = [self.dataSource graphViewNumberOfPlots:self];
	
	if (!numberOfPlots) {
		return;
	}
	
	CGFloat offsetX = _drawAxisY ? 60.0f : 10.0f;
	CGFloat offsetY = (_drawAxisX || _drawInfo) ? 30.0f : 10.0f;
	
	CGFloat minY = 0.0;
	CGFloat maxY = 0.0;
	
	UIFont *font = [UIFont systemFontOfSize:11.0f];
	
	for (NSUInteger plotIndex = 0; plotIndex < numberOfPlots; plotIndex++) {
		
		NSArray *values = [self.dataSource graphView:self yValuesForPlot:plotIndex];
		
		for (NSUInteger valueIndex = 0; valueIndex < values.count; valueIndex++) {
			
			if ([values[valueIndex] floatValue] > maxY) {
				maxY = [values[valueIndex] floatValue];
			}
		}
	}
	
	if (maxY < 100) {
		maxY = ceil(maxY / 10) * 10;
	} 
	
	if (maxY > 100 && maxY < 1000) {
		maxY = ceil(maxY / 100) * 100;
	} 
	
	if (maxY > 1000 && maxY < 10000) {
		maxY = ceil(maxY / 1000) * 1000;
	}
	
	if (maxY > 10000 && maxY < 100000) {
		maxY = ceil(maxY / 10000) * 10000;
	}
	
	CGFloat step = (maxY - minY) / 5;
	CGFloat stepY = (self.frame.size.height - (offsetY * 2)) / maxY;
	
	for (NSUInteger i = 0; i < 6; i++) {
		
		NSUInteger y = (i * step) * stepY;
		NSUInteger value = i * step;
		
		if (_drawGridY) {
			
			CGFloat lineDash[2];
			lineDash[0] = 6.0f;
			lineDash[1] = 6.0f;
			
			CGContextSetLineDash(c, 0.0f, lineDash, 2);
			CGContextSetLineWidth(c, 0.1f);
			
			CGPoint startPoint = CGPointMake(offsetX, self.frame.size.height - y - offsetY);
			CGPoint endPoint = CGPointMake(self.frame.size.width - offsetX, self.frame.size.height - y - offsetY);
			
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
			
			CGContextSetStrokeColorWithColor(c, self.gridYColor.CGColor);
			CGContextStrokePath(c);
		}
		
		if (i > 0 && _drawAxisY) {
			
            NSNumber *valueToFormat = @(value);
			NSString *valueString;
			
			if (_yValuesFormatter) {
				valueString = [_yValuesFormatter stringForObjectValue:valueToFormat];
			} else {
				valueString = [valueToFormat stringValue];
			}
			
			[self.yValuesColor set];
			CGRect valueStringRect = CGRectMake(0.0f, self.frame.size.height - y - offsetY, 50.0f, 20.0f);
			
            // from ios7
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = NSTextAlignmentRight;
            [valueString drawInRect:valueStringRect withAttributes: @{NSFontAttributeName: font,
                                                                   NSParagraphStyleAttributeName: paragraphStyle,
                                                                      NSForegroundColorAttributeName: [UIColor whiteColor]}];
            // deprecated
			/*[valueString drawInRect:valueStringRect withFont:font
					  lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentRight];*/
		}
	}
	
	NSUInteger maxStep;
	
	NSArray *xValues = [self.dataSource graphViewXValues:self];
	NSUInteger xValuesCount = xValues.count;
	
	if (xValuesCount > 5) {
		
		NSUInteger stepCount = 5;
		NSUInteger count = xValuesCount - 1;
		
		for (NSUInteger i = 4; i < 8; i++) {
			if (count % i == 0) {
				stepCount = i;
			}
		}
		
		step = xValuesCount / stepCount;
		maxStep = stepCount + 1;
		
	} else {
		
		step = 1;
		maxStep = xValuesCount;
	}
	
	CGFloat stepX = (self.frame.size.width - (offsetX * 2)) / (xValuesCount - 1);
	
	for (NSUInteger i = 0; i < maxStep; i++) {
		
		NSUInteger x = (i * step) * stepX;
		
		if (x > self.frame.size.width - (offsetX * 2)) {
			x = self.frame.size.width - (offsetX * 2);
		}
		
		NSUInteger index = i * step;
		
		if (index >= xValuesCount) {
			index = xValuesCount - 1;
		}
		
		if (_drawGridX) {
			
			CGFloat lineDash[2];
			
			lineDash[0] = 6.0f;
			lineDash[1] = 6.0f;
			
			CGContextSetLineDash(c, 0.0f, lineDash, 2);
			CGContextSetLineWidth(c, 0.1f);
			
			CGPoint startPoint = CGPointMake(x + offsetX, offsetY);
			CGPoint endPoint = CGPointMake(x + offsetX, self.frame.size.height - offsetY);
			
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
			
			CGContextSetStrokeColorWithColor(c, self.gridXColor.CGColor);
			CGContextStrokePath(c);
		}
		
		if (_drawAxisX) {
			
			id valueToFormat = xValues[index];
			NSString *valueString;
			
			if (_xValuesFormatter) {
				valueString = [_xValuesFormatter stringForObjectValue:valueToFormat];
			} else {
				valueString = [NSString stringWithFormat:@"%@", valueToFormat];
			}
			
			[self.xValuesColor set];
            
            // from ios7
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            [valueString drawInRect:CGRectMake(x, self.frame.size.height - 20.0f, 120.0f, 20.0f) withAttributes:
                @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor whiteColor]}];
            
            // deprecated
			/*[valueString drawInRect:CGRectMake(x, self.frame.size.height - 20.0f, 120.0f, 20.0f) withFont:font
					  lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];*/
		}
	}
	
	stepX = (self.frame.size.width - (offsetX * 2)) / (xValuesCount - 1);
	
	CGContextSetLineDash(c, 0, NULL, 0);
	
	for (NSUInteger plotIndex = 0; plotIndex < numberOfPlots; plotIndex++) {
		
		NSArray *values = [self.dataSource graphView:self yValuesForPlot:plotIndex];
		BOOL shouldFill = NO;
		
		if ([self.dataSource respondsToSelector:@selector(graphView:shouldFillPlot:)]) {
			shouldFill = [self.dataSource graphView:self shouldFillPlot:plotIndex];
		}
		
		CGColorRef plotColor = [S7GraphView colorByIndex:plotIndex].CGColor;
		
		for (NSUInteger valueIndex = 0; valueIndex < values.count - 1; valueIndex++) {
			
			NSUInteger x = valueIndex * stepX;
			NSUInteger y = [values[valueIndex] intValue] * stepY;
			
			CGContextSetLineWidth(c, 1.5f);
			
			CGPoint startPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);
			
			x = (valueIndex + 1) * stepX;
			y = [values[valueIndex + 1] intValue] * stepY;
			
			CGPoint endPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);
			
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
			
			CGContextSetStrokeColorWithColor(c, plotColor);
			CGContextStrokePath(c);
			
			if (shouldFill) {
				
				CGContextMoveToPoint(c, startPoint.x, self.frame.size.height - offsetY);
				CGContextAddLineToPoint(c, startPoint.x, startPoint.y);
				CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
				CGContextAddLineToPoint(c, endPoint.x, self.frame.size.height - offsetY);
				CGContextClosePath(c);
				
				CGContextSetFillColorWithColor(c, plotColor);
				CGContextFillPath(c);
			}
		}
	}
	
	if (_drawInfo) {
		
		font = [UIFont boldSystemFontOfSize:13.0f];
		[self.infoColor set];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [_info drawInRect:CGRectMake(0.0f, 5.0f, self.frame.size.width, 20.0f) withAttributes:
         @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        // deprecated
		//[_info drawInRect:CGRectMake(0.0f, 5.0f, self.frame.size.width, 20.0f) withFont:font
		//	lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentCenter];*/
	}
    
    // Leyenda
    
    int xRectangulo = self.frame.size.width * 0.75;
    int xTexto = xRectangulo+20;
    int yMin = 20;
    int yPos = yMin;
    int ySep = 15;
    int frameMargin = 10;
    int radioRectangulo = 5;

    CGRect rectanguloLeyenda = CGRectMake(xRectangulo, yPos - radioRectangulo, radioRectangulo * 2, radioRectangulo * 2);
    
    // Inicializa datos texto
    //CGContextSelectFont(c, "Helvetica-Bold", 12, kCGEncodingMacRoman); // deprecated
    CGContextSetTextDrawingMode(c, kCGTextFill); // This is the default
    [[UIColor whiteColor] setFill]; // This is the default
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(c, transform);
    
    int maxTextLength = 0;
    
    for(int plot=0;plot < numberOfPlots; plot++) {

        // Dibuja rectangulo
        UIColor *color = [S7GraphView colorByIndex: plot];
        CGColorRef colorRef = [color CGColor];
        
        rectanguloLeyenda.origin.y = yPos;
        
        // TODO (a) Dibuja rectángulo en pantalla para la leyenda de la grafica
        // 1. Establece color de relleno a colorRef
        // 2. Establece el color de contorno a blanco
        // 3. Dibuja contorno del rectángulo rectanguloLeyenda
        // 4. Dibuja relleno del rectángulo rectanguloLeyenda
        
        // ...
        
        // Dibuja texto
        NSString *texto = [self.dataSource graphView:self legendForPlot:plot];

        // TODO (b) Dibuja el texto de la leyenda
        // 1. Establece blanco como color de relleno
        // 2. Muestra la cadena texto en la posición (xTexto, yPos)
        
        // ...
        
        // deprecated
        /*CGContextShowTextAtPoint(c, xTexto, yPos + radioRectangulo*2,
                                 [texto cStringUsingEncoding: NSMacOSRomanStringEncoding],
                                 [texto length]);*/
        
        // Obtenemos posición final del texto dibujado
        CGPoint textPosition = CGContextGetTextPosition(c);
        if(textPosition.x > maxTextLength) {
            // Almacenamos la máxima posición final del texto
            maxTextLength = textPosition.x;
        }
        
        yPos += ySep;
    }
    
    CGRect recuadro = CGRectMake(xRectangulo - frameMargin, yMin - frameMargin, maxTextLength - xRectangulo + frameMargin*2 , yPos - ySep - yMin + radioRectangulo*2 + frameMargin*2);
    
    // (c) Dibuja recuadro para la leyenda 
    // 1. Establece blanco como color de contorno
    // 2. Dibuja el contorno del rectángulo recuadro

    // ...
}

- (void)reloadData {
	
	[self setNeedsDisplay];
}

#pragma mark PrivateMethods

- (void)initializeComponent {
	
	_drawAxisX = YES;
	_drawAxisY = YES;
	_drawGridX = YES;
	_drawGridY = YES;
	
	_xValuesColor = [UIColor blackColor];
	_yValuesColor = [UIColor blackColor];
	
	_gridXColor = [UIColor blackColor];
	_gridYColor = [UIColor blackColor];
	
	_drawInfo = NO;
	_infoColor = [UIColor blackColor];
}

@end
