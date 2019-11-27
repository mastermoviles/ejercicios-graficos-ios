//
//  ViewController.swift
//  PieChartCG
//
//  Created by Master Móviles on 3/11/16.
//  Copyright © 2016 Master Móviles. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController{
    
    var captureSession : AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Creamos vista y añadimos a  la vista actual
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        pieChartView.segments = [
            Segment(color: UIColor.red, value: 20, texto: "Vídeo en directo"),
            Segment(color: UIColor.blue, value: 74, texto: "Vídeo bajo demanda" ),
            Segment(color: UIColor.yellow, value: 3, texto: "Audio"),
            Segment(color: UIColor.green, value: 3, texto: "Otros")
        ]
        pieChartView.titulo = "NetFlua (Plataforma VOD)"
        view.addSubview(pieChartView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

