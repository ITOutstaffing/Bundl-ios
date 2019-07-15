//
//  LoginSellerVC.swift
//  Bundle
//
//  Created by Алексей Ляшенко on 7/9/19.
//  Copyright © 2019 Алексей Ляшенко. All rights reserved.
//

import UIKit

class LoginSellerVC: UIViewController {
    
    @IBOutlet weak var viewWithButiqueButton: UIView!
    @IBOutlet weak var viewWithPartnerButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        shadows under views
        viewWithButiqueButton.layer.shadowColor = UIColor.gray.cgColor
        viewWithButiqueButton.layer.shadowRadius = 4
        viewWithButiqueButton.layer.shadowOpacity = 0.5
        viewWithButiqueButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        viewWithPartnerButton.layer.shadowColor = UIColor.gray.cgColor
        viewWithPartnerButton.layer.shadowRadius = 4
        viewWithPartnerButton.layer.shadowOpacity = 0.5
        viewWithPartnerButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
    

}
