//
//  ViewController.swift
//  animacion_gym_swift
//
//  Created by Master Móviles 
//  Copyright © 2016 Master Móviles. All rights reserved.
//

import UIKit
import QuartzCore

class CaratulaViewController: UIViewController {
    
    var vistaReverso: UIImageView!
    var vistaFrontal: UIImageView!
    
    @IBOutlet weak var vistaCaratula: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.vistaFrontal = UIImageView(image: UIImage(named: "frontal.jpg")!)
        self.vistaFrontal.frame = self.vistaCaratula.bounds
        self.vistaFrontal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.vistaReverso = UIImageView(image: UIImage(named: "reverso.jpg")!)
        self.vistaReverso.frame = self.vistaCaratula.bounds
        self.vistaReverso.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.vistaCaratula.addSubview(self.vistaFrontal)

    }
    
    @IBAction func goBackMain(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func girarAction(_ sender: UIBarButtonItem) {
        
        if self.vistaFrontal.superview != nil {
            // TODO (c) Hacer transición de tipo giro a la izquierda de vistaFrontal a vistaReverso

        }
        else {
            // TODO (c) Hacer transición de tipo giro a la derecha de vistaReverso a vistaFrontal
            
        }
    }
    
    @IBAction func zoomOutAction(_ sender: UIBarButtonItem) {
        // TODO (d) Hacer una animación de un segundo que cambie el tamaño (bounds) de las vistas self.vistaFrontal y self.vistaReverso a (0,0,160,208). Lo haremos mediante las facilidades de UIView
        
    }
    
    @IBAction func zoomInAction(_ sender: UIBarButtonItem) {
        // TODO (d) Hacer una animación de un segundo que cambie el tamaño (bounds) de las vistas self.vistaFrontal y self.vistaReverso a (0,0,320,416). Lo haremos mediante las facilidades de UIView
        
    }
    
}

