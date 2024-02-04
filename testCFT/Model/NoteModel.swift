//
//  NoteModel.swift
//  testCFT
//
//  Created by Дмитрий on 26.01.2024.
//

import Foundation

struct NoteModel: Codable {
    var text: String = "Type something..."
    var id: UUID = UUID()
}
