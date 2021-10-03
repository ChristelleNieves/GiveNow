//
//  CurrentDonationsView.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class CurrentDonationsView: UIView {
    
    let currentAmountLabel = UILabel()
    let raisedLabel = UILabel()
    let minimumLabel = UILabel()
    let maximumLabel = UILabel()
    let progressBar = UIProgressView()
    let goalReachedLabel = UILabel()
    var isGoalReached = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCurrentAmountLabel()
        setupRaisedLabel()
        setupProgressBar()
        setupMininumLabel()
        setupMaximumLabel()
        setupGoalReachedLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension CurrentDonationsView {
    private func setupCurrentAmountLabel() {
        self.addSubview(currentAmountLabel)
        
        // Attributes
        currentAmountLabel.textColor = UIColor.systemTeal
        currentAmountLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        // Constraints
        currentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentAmountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            currentAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupRaisedLabel() {
        self.addSubview(raisedLabel)
        
        // Attributes
        raisedLabel.text = "raised"
        raisedLabel.textColor = UIColor.black
        raisedLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        // Constraints
        raisedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            raisedLabel.leadingAnchor.constraint(equalTo: currentAmountLabel.trailingAnchor, constant: 10),
            raisedLabel.bottomAnchor.constraint(equalTo: currentAmountLabel.bottomAnchor, constant: -3)
        ])
    }
    
    private func setupProgressBar() {
        self.addSubview(progressBar)
        
        // Attributes
        progressBar.progressViewStyle = .default
        progressBar.progressTintColor = UIColor.systemTeal
        progressBar.layer.cornerRadius = 25
        progressBar.clipsToBounds = true

        // Set the rounded edge for the inner bar
        progressBar.layer.sublayers![1].cornerRadius = 25
        progressBar.subviews[1].clipsToBounds = true
        
        // Constraints
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: currentAmountLabel.bottomAnchor, constant: 30),
            progressBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.90),
            progressBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setupGoalReachedLabel() {
        self.addSubview(goalReachedLabel)
        
        goalReachedLabel.isHidden = true
        
        // Attributes
        goalReachedLabel.text = "Goal reached! 🎉"
        goalReachedLabel.textColor = UIColor.darkGray
        goalReachedLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Constraints
        goalReachedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goalReachedLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 15),
            goalReachedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupMininumLabel() {
        self.addSubview(minimumLabel)
        
        // Attributes
        minimumLabel.text = "0%"
        minimumLabel.textColor = UIColor.lightGray
        minimumLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        // Constraints
        minimumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minimumLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -5),
            minimumLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor)
        ])
    }
    
    private func setupMaximumLabel() {
        self.addSubview(maximumLabel)
        
        // Attributes
        maximumLabel.text = "100%"
        maximumLabel.textColor = UIColor.lightGray
        maximumLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        // Constraints
        maximumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maximumLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -5),
            maximumLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor)
        ])
    }
}

// MARK: Cell Setup

extension CurrentDonationsView {
    func setupWithViewModel(viewModel: CompanyViewModel) {
        if viewModel.currentDonationsDollarAmount >= viewModel.donationGoalDollarAmount {
            isGoalReached = true
            goalReachedLabel.isHidden = false
            progressBar.bounceAnimation()
            progressBar.progressTintColor = UIColor.init(red: 129/255.0, green: 211/255.0, blue: 129/255.0, alpha: 1)
        }
        // Set current amount donated label
        currentAmountLabel.text = "$\(Int(viewModel.currentDonationsDollarAmount))"
        
        // Set the progress bar according to the current amount donated
        let percentOfGoalReached = viewModel.currentDonationsDollarAmount / viewModel.donationGoalDollarAmount
        progressBar.setProgress(percentOfGoalReached, animated: true)
    }
}
