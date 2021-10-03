//
//  DescriptionView.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class DescriptionView: UIView {
    
    let scrollView = UIScrollView()
    let descriptionTitleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupDescriptionTitleLabel()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

extension DescriptionView {
    private func setupScrollView() {
        self.addSubview(scrollView)
        
        // Constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func setupDescriptionTitleLabel() {
        scrollView.addSubview(descriptionTitleLabel)
        
        // Attributes
        descriptionTitleLabel.text = "Description:"
        descriptionTitleLabel.textColor = UIColor.black
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        // Constraints
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        
        // Attributes
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        // Constraints
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionTitleLabel.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Setup with viewModel

extension DescriptionView {
    func setupWithViewModel(viewModel: CompanyViewModel) {
        descriptionLabel.text = viewModel.companyDescription
    }
}
