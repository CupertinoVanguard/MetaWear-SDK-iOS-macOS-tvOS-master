//
//  HeadAndSoundController.swift
//  iOS
//
//  Created by Lekshmi Pillai Chidambarathanu on 7/25/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//


import AVFoundation
import UIKit
import MetaWear
class HeadAndSoundController: UIViewController, SendXYZValues{
    var dataRecieverView : DeviceViewController?
    
  
    var val1 : Double = 0.0
    var val2 : Double = 0.0
    var val3 : Double = 0.0
    
     let PI : Double = 3.14159265359
    @IBOutlet weak var headView: headViewController!
    var playSoundController: PlaySoundsController!
    func sendXYZHeadPosition(value1: Double, value2: Double, value3: Double){
       
        label1.text = String(value1)
        label2.text = String(value2)
        label3.text = String(value3)
        val1 = value1
        val2 = value2
        val3 = value3
        
        headView.setPointerPosition(w: 0.0, x: val1, y: val2, z: val3)
        
        //
        
 
    }
    
  
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    //var dataRecieverView : DeviceViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getSecondaryFusionValues()
        dataRecieverView?.valuesDelegate = self
        //headView.setPointerPosition(w: 0.0, x: val1, y: val2, z: val3)
        
        
        
    }
    @IBAction func startPresser(_ sender: AnyObject) {
        /*
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            self.getSecondaryFusionValues(obj: obj!)
            }.success { result in
                print("Successfully subscribed")
            }.failure { error in
                print("Error on subscribe: \(error)")
        }*/
        loadSounds()
        
    }
    
    
    
     //@IBOutlet weak var deviceStatusLabel: UILabel!
    var device: MBLMetaWear!
    //var timer : Timer?
    //var startTime : TimeInterval?
    
   /**
    override func viewWillAppear(_ animated: Bool) {
        
        loadSounds()
    }*/
    /**
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        device.removeObserver(self, forKeyPath: "state")
        device.led?.flashColorAsync(UIColor.red, withIntensity: 1.0, numberOfFlashes: 3)
        device.disconnectAsync()
    }
 *//*
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        OperationQueue.main.addOperation {
            switch (self.device.state) {
            case .connected:
                self.deviceStatusLabel.text = "Connected";
                self.device.sensorFusion?.mode = MBLSensorFusionMode.imuPlus
                print("Connected")
            case .connecting:
                self.deviceStatusLabel.text = "Connecting";
                print("Connected")
            case .disconnected:
                self.deviceStatusLabel.text = "Disconnected";
                print("disconnected")
            case .disconnecting:
                self.deviceStatusLabel.text = "Disconnecting";
                print("disconnected")
            case .discovery:
                self.deviceStatusLabel.text = "Discovery";
                print("disconnected")
            }
        }
    }*/
    /**
    func getFusionValues(obj: MBLEulerAngleData){
        
        let xS =  String(format: "%.02f", (obj.p))
        let yS =  String(format: "%.02f", (obj.y))
        let zS =  String(format: "%.02f", (obj.r))
        
        let x = radians((obj.p * -1) + 90)
        let y = radians(abs(365 - obj.y))
        let z = radians(obj.r)
        headView.setPointerPosition(w: 0.0, x : x, y: y, z: z)
        playSoundController.updateAngularOrientation(abs(Float(365 - obj.y)))
        
        // Send OSC here
    }*/
    /**
    func getSecondaryFusionValues(){
        headView.setPointerPosition(w: 0.0, x: val1, y: val2, z: val3)
        playSoundController.updateAngularOrientation(abs(Float(val2)))
    }*/
    func radians(_ degree: Double) -> Double {
        return ( PI/180 * degree)
    }
    func degrees(_ radian: Double) -> Double {
        return (180 * radian / PI)
    }
    /*
    @IBAction func startPressed(sender: AnyObject) {
        
        device.sensorFusion?.eulerAngle.startNotificationsAsync { (obj, error) in
            self.getFusionValues(obj: obj!)
            }.success { result in
                print("Successfully subscribed")
            }.failure { error in
                print("Error on subscribe: \(error)")
        }
    }
    
    @IBAction func stopPressed(sender: AnyObject) {
        device.sensorFusion?.eulerAngle.stopNotificationsAsync().success { result in
            print("Successfully unsubscribed")
            }.failure { error in
                print("Error on unsubscribe: \(error)")
        }
    }*/
    func loadSounds(){
        var soundArray : [String] = []
        for index in 0...3{
            soundArray.append(String(index) + ".wav")
        }
        playSoundController = PlaySoundsController(file: soundArray)
        
        playSoundController.updatePosition(index: 0, position: AVAudio3DPoint(x: 0, y: 0, z: -15))
        playSoundController.updatePosition(index: 1, position: AVAudio3DPoint(x: 7.5, y: 10, z: 7.5 * sqrt(2.0)))
        playSoundController.updatePosition(index: 2, position: AVAudio3DPoint(x: 0, y: -2, z: 0))
        playSoundController.updatePosition(index: 3, position: AVAudio3DPoint(x: -100, y: 10, z: -5))
        
        for sounds in soundArray.enumerated(){
            // skip seagguls
            if sounds.offset != 3 {
                playSoundController.play(index: sounds.offset)
            }
        }
        
    }/*
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }*/
 
}

