//
//  DonateViewController.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class DonateViewController: UIViewController {
    
    weak var delegate: DonationDelegate?
    
    let titleLabel = UILabel()
    let donateButton = UIButton()
    let stackView = UIStackView()
    var donationAmountButtons = [UIButton]()
    let donationAmounts = [50, 100, 1000]
    var chosenAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTitleLabel()
        setupStackView()
        setupDonationAmountButtons()
        setupDonateButton()
    }
    
    // Set the height of this view controller
    override func updateViewConstraints() {
        view.frame.size.height = UIScreen.main.bounds.height - UIScreen.main.bounds.height * 1/1.7
        view.frame.origin.y =  UIScreen.main.bounds.height * 1/1.7
        view.layer.cornerRadius = 20
        super.updateViewConstraints()
    }
}

// MARK: - UI Setup

extension DonateViewController {
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        // Attributes
        titleLabel.text = "Choose a donation amount"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        // Attributes
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.backgroundColor = UIColor.clear
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    private func setupDonationAmountButtons() {
        let forestGreen = UIColor.init(red: 129/255.0, green: 211/255.0, blue: 129/255.0, alpha: 0.60)
        
        for _ in donationAmounts {
            let button = UIButton()
            donationAmountButtons.append(button)
        }
        
        for i in 0..<donationAmountButtons.count {
            let button = donationAmountButtons[i]
            let amount = donationAmounts[i]
            
            button.setTitle("$\(amount)", for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: .medium)
            button.backgroundColor = UIColor.secondarySystemBackground
            button.layer.cornerRadius = 18
            stackView.addArrangedSubview(button)
            
            // Action
            button.addAction(UIAction { action in
                button.bounceAnimation()
                
                // Set the current chosen amount
                self.chosenAmount = self.donationAmounts[i]
                
                // Check if there are any other buttons that have been selected and change their background color back to the non-selected color
                for j in 0..<self.donationAmountButtons.count {
                    if i != j {
                        let btn = self.donationAmountButtons[j]
                        if btn.backgroundColor == forestGreen {
                            btn.backgroundColor = UIColor.secondarySystemBackground
                        }
                    }
                }
                
                // Change background color of button selected to green
                button.backgroundColor = forestGreen
            }, for: .touchUpInside)
            
            // Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 80),
                button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/3.5)
            ])
        }
    }
    
    private func setupDonateButton() {
        view.addSubview(donateButton)
        
        // Attributes
        donateButton.setTitle("Donate", for: .normal)
        donateButton.titleLabel?.textColor = UIColor.white
        donateButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        donateButton.backgroundColor = UIColor.systemTeal
        donateButton.layer.cornerRadius = 20
        
        // Action
        donateButton.addAction(UIAction { action in
            self.donateButton.bounceAnimation()
            
            // Haptic feedback on button press
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            guard self.chosenAmount != 0 else {
                // Present alert to user notifying them to choose an amount to donate
                self.presentAlert()
                return
            }
            
            // Send the donation amount back to the main view controller through the delegate
            self.delegate?.addNewDonation(dollarAmount: Float(self.chosenAmount))
            
            // Dismiss self
            self.dismiss(animated: true, completion: nil)
        }, for: .touchUpInside)
        
        // Constraints
        donateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            donateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donateButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            donateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            donateButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

// MARK: - Auxiliary Functions

extension DonateViewController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Oops!", message: "You forgot to choose a donation amount! Please try again.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            alertVC.dismiss(animated: true, completion: nil)
        })
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
