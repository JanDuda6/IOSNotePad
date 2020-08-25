//
//  DataFormatterHelper.swift
//  NotePad
//
//  Created by Kurs on 12/08/2020.
//  Copyright © 2020 Kurs. All rights reserved.
//

import Foundation

struct DataFormatterHelper {
    func dateFormatter(with date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .short
          formatter.locale = Locale(identifier: "pl_PL")
          formatter.dateFormat = "d MMM y, HH:mm"
          return formatter.string(from: date)
      }
}
