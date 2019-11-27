//
//  ViewController.swift
//  VideoPlayer_swift
//
//  Created by Master Móviles on 9/11/16.
//  Copyright © 2016 Master Móviles. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class ViewController: UIViewController {

    var moviePlayer : AVPlayerLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    @objc func videoPlaybackDidFinish(_ notification: Notification) {
        self.moviePlayer?.removeFromSuperlayer()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        self.moviePlayer=nil
        
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        
        let videoURL = Bundle.main.url(forResource: "video", withExtension: "m4v")
         
        
        // TODO (a.1) Reproducir video movieUrl con AVPlayerViewController
        
        // TODO (a.2) Hacer que no se muestre ningún control de reproducción de video, para evitar que el usuario pueda pasar el vídeo. Lo estableceremos mediante la propiedades  del AVPlayerViewController
        
        // TODO (a.3) Hacer que el tamaño del reproductor se ajuste al girar la pantalla. Para ello deberemos definir su propiedad autoresizingMask con UIViewAutoresizingFlexibleHeight y UIViewAutoresizingFlexibleWidth
               
        //TODO (a.4) Utilizando las propiedades del AVPlayerViewController estableceremos los siguientes comportamientos en la reproducción:
            // 1. Hacer que el reeproductor entre en modo pantalla completa al iniciar la reproducción.
            // 2. Hacer que el reproductor salga del modo pantalla completa cuando termine la reproducción
        
                
        
        // TODO (b.1) Reproducir video con AVPlayer + AVPlayerLayer
        // 1. Crear reproductor en self.moviePlayer a partir de movieUrl
        // 2. Ajustar tamaño de la vista del reproductor (self.moviePlayer.frame) al tamaño de la vista actual (self.view.bounds)
        // 3. Añadir a self.view la vista del reproductor (self.moviePlayer.view) como subvista
        // 4. Comenzar la reproducción
        
        
        // TODO (b.2) Escucha notificación de finalizacion de la reproduccion (NotificationCenter.default.addObserver) y llamar en ese caso a videoPlaybackDidFinish: para cerrar el reproductor
        
        // TODO (b.3) Hacer que el tamaño del reproductor de AVPlayerLayer para que se ajuste al girar la pantalla. Para ello deberemos sobreescribir el método viewWillTransition. (el código irá en el método con ese nombre)
                 
        // TODO (b.4) Personalizar el reproductor para que tenga como fondo un color lightGray. Deberemos manipular las propiedades del AVPlayerLayer
        
        
        

    }
}
 
