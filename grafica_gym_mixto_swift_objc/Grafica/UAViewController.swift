//
//  UAViewController.swift
//  Grafica
//
//  Created by Master Móviles on 31/10/16.
//
//

import Foundation

import UIKit

@objc
class UAViewController: UIViewController, S7GraphViewDataSource {
    
    weak var graphView: S7GraphView?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        // Do any additional setup after loading the view, typically from a nib.
        let graphView = S7GraphView(frame: self.view.bounds)
        graphView.dataSource = self
        self.view.addSubview(graphView)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        graphView.yValuesFormatter = numberFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        graphView.xValuesFormatter = dateFormatter
        graphView.backgroundColor = UIColor.black
        graphView.drawAxisX = true
        graphView.drawAxisY = true
        graphView.drawGridX = true
        graphView.drawGridY = true
        graphView.xValuesColor = UIColor.white
        graphView.yValuesColor = UIColor.white
        graphView.gridXColor = UIColor.white
        graphView.gridYColor = UIColor.white
        graphView.drawInfo = true
        graphView.info = "Cuota de mercado"
        graphView.infoColor = UIColor.white
        graphView.reloadData()
        self.graphView = graphView
    }
    
    override func viewDidLayoutSubviews() {
        self.graphView?.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public func graphViewNumber(ofPlots graphView: S7GraphView!) -> UInt {
        return 3
    }
    
    public func graphViewXValues(_ graphView: S7GraphView) -> [Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MM-yyyy"
        return [dateFormatter.date(from: "01-2013")!, dateFormatter.date(from: "07-2013")!, dateFormatter.date(from: "01-2014")!, dateFormatter.date(from: "07-2014")!, dateFormatter.date(from: "01-2015")!]
    }
    
    public func graphView(_ graphView: S7GraphView!, legendForPlot plotIndex: UInt) -> String! {
        switch plotIndex {
        case 0:
            return "iOS"
        case 1:
            return "Android"
        case 2:
            return "Windows Phone"
        default:
            return ""
        }
        
    }
    
    public func graphView(_ graphView: S7GraphView!, yValuesForPlot plotIndex: UInt) -> [Any]! {
        switch plotIndex {
        case 0:
            return [70, 50, 40, 35, 30]
        case 1:
            return [30, 50, 55, 58, 60]
        case 2:
            return [0, 0, 5, 7, 10]
        default:
            return nil
        }
        
    }
}
