//
//  LabelType.swift
//  GitHub's Users API
//
//  Created by Oula mardawi on 08/05/2022.
//


import Foundation

public enum LabelType: Int, CaseIterable {
    case LoginName = 1
    case ID = 2
    case Image = 0
    
    var title: String {
        switch self {
        case .LoginName:
            return "LoginName"
        case .ID:
            return "ID"
        case .Image:
            return "Image"
        }
    }
}
