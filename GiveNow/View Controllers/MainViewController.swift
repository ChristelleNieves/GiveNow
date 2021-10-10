//
//  MainViewController.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel = CompanyViewModel()
    let stackView = UIStackView()
    let logoView = LogoView()
    let descriptionView = DescriptionView()
    let currentDonationsView = CurrentDonationsView()
    let giveNowView = GiveNowView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupStackView()
        setupLogoView()
        setupDescriptionView()
        setupCurrentDonationsView()
        setupGiveNowView()
    }
}

// MARK: - UI Setup

extension MainViewController {
    private func setupStackView() {
        view.addSubview(stackView)
        
        // Attributes
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupLogoView() {
        logoView.delegate = self
        stackView.addArrangedSubview(logoView)
        
        logoView.setupWithViewModel(viewModel: viewModel)
        
        // Constraints
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25),
            logoView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupDescriptionView() {
        stackView.addArrangedSubview(descriptionView)
        
        descriptionView.setupWithViewModel(viewModel: viewModel)
        
        // Constraints
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.37),
            descriptionView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    private func setupCurrentDonationsView() {
        stackView.addArrangedSubview(currentDonationsView)
        
        currentDonationsView.setupWithViewModel(viewModel: viewModel)
        
        // Constraints
        currentDonationsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentDonationsView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.25),
            currentDonationsView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    
    private func setupGiveNowView() {
        stackView.addArrangedSubview(giveNowView)
        
        giveNowView.delegate = self
        
        // Constraints
        giveNowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            giveNowView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.12),
            giveNowView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}

// MARK: - Donation Delegate

extension MainViewController: DonationDelegate {
    func presentDonationViewController() {
        let donateVC = DonateViewController()
        donateVC.delegate = self
        donateVC.modalPresentationStyle = .pageSheet
        donateVC.modalTransitionStyle = .coverVertical
        present(donateVC, animated: true, completion: nil)
    }
    
    func addNewDonation(dollarAmount: Float) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.currentDonationsDollarAmount += dollarAmount
            self.currentDonationsView.setupWithViewModel(viewModel: self.viewModel)
        }
    }
}

// MARK: - PhotoPickerDelegate

extension MainViewController: PhotoPickerDelegate {
    func presentPhotoPicker() {
        let photoPickerVC = UIImagePickerController()
        photoPickerVC.delegate = self
        present(photoPickerVC, animated: true, completion: nil)
    }
}

// MARK: - ImagePicker Delegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoView.logoImageView.image = pickedImage
            logoView.logoImageView.contentMode = .scaleToFill
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
