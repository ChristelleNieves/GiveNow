//
//  DonationDelegate.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import Foundation

protocol DonationDelegate: AnyObject {
    func presentDonationViewController()
    func addNewDonation(dollarAmount: Float)
}
