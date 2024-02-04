//
//  NoteCell.swift
//  testCFT
//
//  Created by Дмитрий on 26.01.2024.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    static let identifier = "\(NoteCell.self)"
    
    //MARK: UI
    
    var notesText: UILabel = {
        let notes = UILabel()
        notes.numberOfLines = 2
        notes.lineBreakMode = .byWordWrapping
        notes.textColor = .black
        return notes
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    //MARK: Lifecycle
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func configure(with note: NoteModel) {
        notesText.text = note.text
    }
    
    private func setupUI() {
        [background, notesText].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            notesText.centerXAnchor.constraint(equalTo: centerXAnchor),
            notesText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    
}
