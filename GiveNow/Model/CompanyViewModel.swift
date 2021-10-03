//
//  CompanyViewModel.swift
//  GiveNow
//
//  Created by Christelle Nieves on 10/2/21.
//

import Foundation
import UIKit

public class CompanyViewModel {
    var companyName = "Global Earth Conservation"
    var companyImage = UIImage(named: "Logo")
    var companyDescription = "The Global Earth Conservation is dedicated to saving our planet by planting millions of trees all over the world. By planting trees, we are contributing to the preservation of wildlife and clean air for today and future generations to come. We believe that if we work together we can save the place we call home. Donate now to help save our planet!"
    var currentDonationsDollarAmount: Float = 1900
    var donationGoalDollarAmount: Float = 5000
}
