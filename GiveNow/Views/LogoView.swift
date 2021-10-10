//
//  LogoView.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class LogoView: UIView {
    
    weak var delegate: PhotoPickerDelegate?
    let logoImageView = UIImageView()
    let companyNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupLogoImageView()
        setupCompanyNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension LogoView {
    private func setupLogoImageView() {
        self.addSubview(logoImageView)
        
        // Attributes
        logoImageView.backgroundColor = UIColor.clear
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.isUserInteractionEnabled = true
        
        // Action to upload image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        logoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // Constraints
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80)
        ])
    }
    
    private func setupCompanyNameLabel() {
        self.addSubview(companyNameLabel)
        
        // Attributes
        companyNameLabel.textColor = UIColor.darkGray.withAlphaComponent(0.70)
        companyNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        companyNameLabel.numberOfLines = 0
        companyNameLabel.lineBreakMode = .byWordWrapping
        
        // Constraints
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 10),
            companyNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        self.delegate?.presentPhotoPicker()
    }
}

// MARK: - View Setup

extension LogoView {
    func setupWithViewModel(viewModel: CompanyViewModel) {
        
        // Set the company logo image
        logoImageView.image = viewModel.companyImage
        
        // Set the company name
        companyNameLabel.text = viewModel.companyName
    }
}
