//
//  extansion.swift
//  Bundle
//
//  Created by Алексей Ляшенко on 7/15/19.
//  Copyright © 2019 Алексей Ляшенко. All rights reserved.
//

import UIKit
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
        
    }
}
