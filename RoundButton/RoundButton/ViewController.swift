//
//  ViewController.swift
//  RoundButton
//
//  Created by altaibayar tseveenbayar on 04/06/16.
//  Copyright © 2016 tsevealt. All rights reserved.
//

import UIKit

class ViewController: UIViewController 
{
    var roundButtons: [RoundButton] = [RoundButton]();
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
    
        self.roundButtons = self.createButtons();
        for btn in self.roundButtons {
            self.view.addSubview(btn);
        }
    }

    override func viewDidLayoutSubviews() 
    {
        super.viewDidLayoutSubviews();
    
        for (idx, btn) in self.roundButtons.enumerate()
        {
            btn.frame = self.frameForButton(idx);           
        }
    }
    
    //MARK: helper

    func createButtons() -> [RoundButton]
    {
        return RoundButtonStyle.allValues.map { (style) -> RoundButton in
            let btn = RoundButton();
            btn.setStyle(style);
            
            let colorPair = self.randomBeautifulColorPair();
            btn.lineColor = colorPair.1;
            btn.roundColor = colorPair.0;
            
            btn.innerLineWidth = randomWidth();
            btn.roundLineWidth = randomWidth();
            
            return btn;            
        };
    }
    
    func frameForButton(idx: Int) -> CGRect
    {
        let s: CGFloat = CGRectGetWidth(self.view.frame) / 3;        
        let rect = CGRectMake(CGFloat( (idx % 3) ) * s, CGFloat( (idx / 3) ) * s + 100, s, s);
        
        return CGRectInset(rect, 8, 8);
    }
    
    //MARK: random values
    
    func randomBeautifulColorPair() -> (UIColor, UIColor)
    {
        let colors = [ 
            (UIColor.orangeColor(), UIColor.cyanColor()),
            (UIColor.whiteColor(), UIColor.yellowColor()),
            (UIColor.brownColor(), UIColor.redColor()),
            (UIColor.magentaColor(), UIColor.purpleColor())             
        ];
        
        return colors[random() % colors.count];
    }
    
    func randomWidth() -> CGFloat
    {
        let r = CGFloat(random());        
        return r % 8.0;
    }
}

