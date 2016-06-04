//
//  RoundButton.swift
//  VisualRuler
//
//  Created by altaibayar tseveenbayar on 04/05/16.
//  Copyright © 2016 tsevealt. All rights reserved.
//

import UIKit
import Foundation

@objc enum RoundButtonStyle : NSInteger {
    case Camera, Picture, OK, Rectangle, Line, Add, Remove, CameraNotAvailable, PictureNotAvailable
    
    static let allValues = [Camera, Picture, OK, Rectangle, Line, Add, Remove, CameraNotAvailable, PictureNotAvailable];
}

class RoundButton : UIButton
{
    //MARK: public properties
    var lineColor: UIColor = UIColor.redColor() {
        didSet { self.setNeedsLayout(); }
    }
    var roundColor: UIColor = UIColor.redColor() {
        didSet { 
            self.setTitleColor(self.roundColor, forState: .Normal); 
            self.setNeedsLayout(); 
        }
    }
    var roundLineWidth: CGFloat = 1 {
        didSet { self.setNeedsLayout(); }
    }
    var innerLineWidth: CGFloat = 1 {
        didSet { self.setNeedsLayout(); }
    }
    
    //MARK: private properties
    private var points = [[CGPoint]]() {
        didSet { self.setNeedsLayout(); }
    }

    private var lineLayer: CAShapeLayer = CAShapeLayer();

    override func willMoveToSuperview(newSuperview: UIView?) 
    {
        super.willMoveToSuperview(newSuperview);
        self.backgroundColor = UIColor.clearColor();
        
        if let _ = newSuperview
        {
            self.lineLayer.fillColor = nil;
            self.lineLayer.opacity = 1.0;
            self.lineLayer.lineJoin = kCALineJoinRound;
            self.lineLayer.lineCap = kCALineCapRound;

            self.layer.masksToBounds = true;
            self.layer.addSublayer(self.lineLayer);
            
            self.titleLabel?.font = UIFont.systemFontOfSize(12.0);
        }
    }
    
    override func layoutSubviews() 
    {
        super.layoutSubviews();

        self.layer.borderWidth = roundLineWidth;
        self.layer.borderColor = self.roundColor.CGColor;
        self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.0;

        self.lineLayer.lineWidth = innerLineWidth;
        self.lineLayer.frame = self.bounds;        
        self.lineLayer.strokeColor = self.lineColor.CGColor;
        
        updateLineLayer();
    }
    
    func updateLineLayer()
    {        
        let path = UIBezierPath();
        path.lineWidth = innerLineWidth;
        
        for line: [CGPoint] in points
        {
            if line.count == 1
            {
                let p = real(line[0]);
                let oval = UIBezierPath(ovalInRect: CGRectMake(p.x - (u() / 4.0), p.y - (u() / 4.0), u() / 2, u() / 2));
                path.appendPath(oval);
            } 
            else 
            {                
                let linePath = UIBezierPath();
                
                linePath.moveToPoint(real(line[0]));
                for point: CGPoint in line { linePath.addLineToPoint(real(point)); }
                linePath.closePath();
                
                path.appendPath(linePath);
            }
        }

        self.lineLayer.path = path.CGPath;
    }
}

//Styles
extension RoundButton
{
    func setStyle(style: RoundButtonStyle)
    {
        switch style 
        {
        case .Camera: self.setStyle_Camera();
        case .Picture: self.setStyle_Picture();
        case .OK: self.setStyle_OK();
        case .Rectangle: self.setStyle_Rectangle();
        case .Line: self.setStyle_Line();
        case .Add: self.setStyle_Add();
        case .Remove: self.setStyle_Remove();
        case .CameraNotAvailable: self.setStyle_CameraNotAvailable();
        case .PictureNotAvailable: self.setStyle_PictureNotAvailable();
        }
    }
    
    private func setStyle_Camera()
    {
        points = [
            [ p(1.5, 1), p(4, 2.5), p(1.5, 4) ]
        ];
    }
    
    private func setStyle_Picture()
    {
        points = [
            [ p(1.5, 1.5)], [p(2.5, 1.5)], [p(3.5, 1.5) ],
            [ p(1.5, 2.5)], [p(2.5, 2.5)], [p(3.5, 2.5) ],
            [ p(1.5, 3.5)], [p(2.5, 3.5)], [p(3.5, 3.5) ]        
        ];
    }
    
    private func setStyle_OK()
    {
        points = [[ p(1, 3), p(2, 4), p(4, 2), p(2, 4) ]];
    }

    private func setStyle_Rectangle()
    {
        points = [
            [ p(1.5, 1.5), p(3.5, 1.5), p(3.5, 3.5), p(1.5, 3.5) ]
        ];
    }
    
    private func setStyle_Line()
    {
        points = [
            [p(1, 2.5), p(4, 2.5)]
        ];
    }
    
    private func setStyle_Add()
    {
        points = [
            [ p(2.5, 1), p(2.5, 4) ],
            [ p(1, 2.5), p(4, 2.5) ]
        ];
    }
    
    private func setStyle_Remove()
    {
        points = [
            [ p(1.5, 1.5), p(3.5, 3.5) ],
            [ p(3.5, 1.5), p(1.5, 3.5) ]        
        ];
    }
    
    private func setStyle_CameraNotAvailable()
    {
        points = [
            [ p(1.5, 1), p(4, 2.5), p(1.5, 4) ], //camera
            [ p(0.0, 0.0), p(5.0, 5.0)] //cross
        ];

    }
    
    private func setStyle_PictureNotAvailable()
    {
        points = [
            [ p(1.5, 1.5)], [p(2.5, 1.5)], [p(3.5, 1.5) ],
            [ p(1.5, 2.5)], [p(2.5, 2.5)], [p(3.5, 2.5) ],
            [ p(1.5, 3.5)], [p(2.5, 3.5)], [p(3.5, 3.5) ],
            [ p(0.0, 0.0), p(5.0, 5.0) ] //cross
        ];
    }
}

//LAZINESS
extension RoundButton
{
    private func real(p: CGPoint) -> CGPoint
    {
        return CGPointMake(p.x * u(), p.y * u());
    }
    
    private func u() -> CGFloat
    {
        return CGRectGetWidth(self.frame) / 5.0;
    }
    
    private func p(x: CGFloat, _ y: CGFloat) -> CGPoint
    {
        return CGPointMake(x, y);
    }
}