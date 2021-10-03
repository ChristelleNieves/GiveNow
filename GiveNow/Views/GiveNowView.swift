//
//  GiveNowView.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class GiveNowView: UIView {
    
    weak var delegate: DonationDelegate?
    
    let giveNowButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupGiveNowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension GiveNowView {
    private func setupGiveNowButton() {
        self.addSubview(giveNowButton)
        
        // Attributes
        giveNowButton.setTitle("Give Now", for: .normal)
        giveNowButton.backgroundColor = UIColor.systemTeal
        giveNowButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        giveNowButton.layer.cornerRadius = 25
        
        // Action
        giveNowButton.addAction(UIAction { action in
            self.giveNowButton.bounceAnimation()
            self.delegate?.presentDonationViewController()
        }, for: .touchUpInside)
        
        // Constraints
        giveNowButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            giveNowButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            giveNowButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            giveNowButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.60),
            giveNowButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
