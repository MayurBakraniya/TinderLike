//
//  ViewController.swift
//  TinderLike
//
//  Created by MAC on 24/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var nopeImg: UIImageView!
    @IBOutlet weak var mainImg: UIImageView!
    
    var diviser : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diviser = (view.frame.width / 2) / 0.61
    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromLeft = card.center.x - view.center.x
       
        
        card.center = CGPoint(x: view.center.x + point.x , y: view.center.y + point.y)
        
        let scale = min(100/abs(xFromLeft), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromLeft/diviser).scaledBy(x: scale, y: scale)
        
        if xFromLeft > 0{
            likeImg.image = #imageLiteral(resourceName: "yes")
            likeImg.tintColor = #colorLiteral(red: 0.2177098989, green: 0.624876976, blue: 0.4092328846, alpha: 1)
            likeImg.alpha = abs(xFromLeft) / view.center.x
        }else{
            nopeImg.image = #imageLiteral(resourceName: "nope")
            nopeImg.tintColor = #colorLiteral(red: 0.5713999867, green: 0.2389647663, blue: 0.3188518584, alpha: 1)
            nopeImg.alpha = abs(xFromLeft) / view.center.x
        }
        
//        likeImg.alpha = abs(xFromLeft) / view.center.x
//        nopeImg.alpha = abs(xFromLeft) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended{
            
            if card.center.x < 75{
                
                UIView.animate(withDuration: 0.3,animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            }else if card.center.x > (view.frame.width - 75){
                UIView.animate(withDuration: 0.3,animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                    return
                })
            }
            resetCard()
        }
      
    }

    @IBAction func resetButton(_ sender: UIButton) {
       resetCard()
    }
    
    func resetCard(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.center = self.view.center
            self.likeImg.alpha = 0
            self.nopeImg.alpha = 0
            self.card.alpha = 1
            self.card.transform = .identity
        })
    }
    
    @IBAction func nopeButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3,animations: {
            self.card.center = CGPoint(x: self.card.center.x - 200, y: self.card.center.y + 75)
            self.card.alpha = 0
        })
    }
    @IBAction func likeButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3,animations: {
            self.card.center = CGPoint(x: self.card.center.x + 200, y: self.card.center.y + 75)
            self.card.alpha = 0
            self.card.transform = .identity
        })
    }
}

