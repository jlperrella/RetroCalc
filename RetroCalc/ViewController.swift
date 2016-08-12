//
//  ViewController.swift
//  RetroCalc
//
//  Created by jp on 2016-08-11.
//  Copyright © 2016 jp. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Enums begin with Caps
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNum = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    
    //Called when the main view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path =
            NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        //DO BLOCK
        do {
            //creates error in anticipaiton of the AVAudioplayer breaking, must use a DO BLOCK
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }

    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound ()
        runningNum += "\(btn.tag)"
        outputLbl.text = runningNum
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation (Operation.Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation (Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation (Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation (Operation.Add)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation (currentOperation)
    }
    
    
    func processOperation (op: Operation) {
           playSound ()
        
        if (currentOperation != Operation.Empty) {
            
            //fixes crash error if leftValStr or rightValStr = nil
            if runningNum != "" {
                rightValStr = runningNum
                runningNum = ""
                
                // In order to print result we need to convert strings to numbers, calculate those numbers, and convert back to string
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
                
            }
        
            currentOperation = op
            
        } else {
            leftValStr = runningNum
            runningNum = ""
            currentOperation = op
        }

    }

    func playSound () {
        if (btnSound.playing){
            btnSound.stop()
        }
        btnSound.play()
    }
}

