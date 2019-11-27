//
//  PieChartView.swift
//  PieChartCG
//
//  Created by Master Móviles on 3/11/16.
//  Copyright © 2016 Master Móviles. All rights reserved.
//

import UIKit

struct Segment {
    
    // color
    var color : UIColor
    
    // valor segmento
    var value : CGFloat
    
    // cadena
    var texto : String
}

class PieChartView: UIView {
    
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay() // re-draw
        }
    }
    
    var titulo = String() {
        didSet {
            setNeedsDisplay() // re-draw
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        // contexto actual
        let ctx = UIGraphicsGetCurrentContext()
        
        // gradiente
        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        let colorspace = CGColorSpaceCreateDeviceGray()
        let gradient = CGGradient(colorsSpace: colorspace,
                                  colors: colors as CFArray, locations: locations)
        
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        ctx?.drawLinearGradient(gradient!, start: startPoint,
                                    end: endPoint, options:
            CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        // radio grafico (min(ancho,alto) / 2)
        let radius = min(frame.size.width, frame.size.height)*0.4
        
        // radio del tamaño de la vista
        let realRadius = min(frame.size.width, frame.size.height)*0.5

        // centro de la vista
        let viewCenter = CGPoint(x: bounds.size.width*0.5, y: bounds.size.height*0.5)
        
        // normalización 0..1
        let valueCount = segments.reduce(0) {$0 + $1.value}
        
        // -90 grados (parte superior del circulo). 
        // Por defecto, 0 es la parte derecha del círculo siendo el ángulo positivo en dirección anti-horaria, 
        var startAngle = -CGFloat(Double.pi*0.5)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attrsTextoTitulo = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont(name: "HelveticaNeue-Bold", size: 15)!,
                     convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle): paragraphStyle,
                     convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.white]
        
        let attrsTextoLeyenda = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont(name: "HelveticaNeue-Bold", size: 12)!,
                           convertFromNSAttributedStringKey(NSAttributedString.Key.paragraphStyle): paragraphStyle,
                           convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.white]
        
        
        let myShadowOffset = CGSize(width: -10, height: 15)
        (ctx)!.saveGState()
        (ctx)!.setShadow (offset: myShadowOffset, blur: 5)
        
        for segment in segments { // loop through the values array
            
            // color relleno segmento
            ctx?.setFillColor(segment.color.cgColor)
            
            // actualización ángulo
            let endAngle = startAngle+CGFloat(Double.pi*2)*(segment.value/valueCount)
            
            // nos movemos al centro del gráfico
            ctx?.move(to: CGPoint( x: viewCenter.x, y: viewCenter.y) )
            
            // pintamos arcoa
            ctx?.addArc( center: CGPoint( x: viewCenter.x, y: viewCenter.y ), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            // fill segment
            ctx?.fillPath()
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
        
        ctx!.restoreGState()
        
        // titulo piechart
        let topMargin : CGFloat = 5
        titulo.draw(with: CGRect(x: viewCenter.x - realRadius + 5, y: viewCenter.y - realRadius + topMargin, width: bounds.size.width/2, height: 20),   options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(attrsTextoTitulo), context: nil)
        
        let comienzoLeyenda = CGPoint(x: 20, y: 20)
        var comienzoTextoLeyenda = comienzoLeyenda
        
        // max 2d position x-axis
        var maxX : CGFloat = 0.0
        for segment in segments { // loop through the values array
            let rect_leyenda = CGRect(x: comienzoTextoLeyenda.x + 5, y: comienzoTextoLeyenda.y + 5, width: 15, height: 15)
            ctx?.setFillColor(segment.color.cgColor)
            ctx?.fill(rect_leyenda)
            
            paragraphStyle.alignment = .left
            segment.texto.draw(with: CGRect(x: comienzoTextoLeyenda.x + 25, y: comienzoTextoLeyenda.y + 5, width: 200, height: 15),   options: .usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(attrsTextoLeyenda), context: nil)
            
            comienzoTextoLeyenda.y += 20
            
            // comprobamos ultima posicion eje x donde se dibujo
            let position : CGPoint = ctx!.textPosition
            if position.x > maxX { maxX = position.x }
        }
        
        let position : CGPoint = (ctx?.textPosition)!
        
        // leyenda (dibujar lo último, compute width and height)
        let rectangulo = CGRect(x: comienzoLeyenda.x, y: comienzoLeyenda.y, width: maxX - 20 + 5, height: position.y - 20 + 10)
        ctx?.stroke(rectangulo)
        
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
