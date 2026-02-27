//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Emircan Özer on 26.02.2026.
//

import Foundation


extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
