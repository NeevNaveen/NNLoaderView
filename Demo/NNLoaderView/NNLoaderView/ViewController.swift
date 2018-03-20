//
//  ViewController.swift
//  NNLoaderView

import UIKit

class ViewController: UIViewController {

    var doneLoading: Bool = false;
    @IBOutlet var segment: UISegmentedControl!;
    @IBOutlet var numberOfCircle: UITextField!;
    @IBOutlet var loadMessage: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        if !doneLoading {
            doneLoading = true;
            NNLoaderView.shared.show(inView: self.view);
        }
    }
    
    @IBAction func changeIt () {
        if segment.selectedSegmentIndex == 0 {
            NNLoaderView.shared.animationType = .scale;
        } else if segment.selectedSegmentIndex == 1 {
            NNLoaderView.shared.animationType = .bounce;
        }  else if segment.selectedSegmentIndex == 2 {
            NNLoaderView.shared.animationType = .fadeInOutLenear;
        }  else if segment.selectedSegmentIndex == 3 {
            NNLoaderView.shared.animationType = .changeColor;
        }
    }
    
    
    @IBAction func resetLoaderView ()
    {
        NNLoaderView.shared.remove();
        loadMessage.resignFirstResponder();
        numberOfCircle.resignFirstResponder();

        if let string = loadMessage.text, !string.isEmpty {
            /* string is not blank */
            NNLoaderView.shared.message = string;
        }

        if let string = numberOfCircle.text, !string.isEmpty {
            /* string is not blank */
            NNLoaderView.shared.circleCount = Int(string)!;
        }
        
        NNLoaderView.shared.show(inView: self.view);
    }
    
}

