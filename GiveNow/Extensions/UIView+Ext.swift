//
//  UIView+Ext.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import Foundation
import UIKit

extension UIView {
    func bounceAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(4.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}
