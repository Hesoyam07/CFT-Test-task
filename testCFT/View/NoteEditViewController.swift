//
//  NoteEditViewController.swift
//  testCFT
//
//  Created by Дмитрий on 26.01.2024.
//

import UIKit

protocol NoteEditViewControllerDelegate: AnyObject {
    func didSaveNoteWith(id: UUID, text: String)
}

final class NoteEditViewController: UIViewController {
    
    weak var delegate: NoteEditViewControllerDelegate?
    var noteId: UUID?
    
    //MARK: UI
    
    private let noteTitle: UILabel = {
        let note = UILabel()
        note.text = "Заметка"
        note.textColor = .black
        note.font = .boldSystemFont(ofSize: 28)
        return note
    }()
    
    private let textInput: UITextView = {
        let tv = UITextView()
        tv.isEditable = true
        tv.layer.cornerRadius = 10
        tv.backgroundColor = .white
        tv.font = .boldSystemFont(ofSize: 18)
        tv.textColor = .black
        return tv
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        view.backgroundColor = .systemOrange
        saveButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        getNote()
    }
    
    //MARK: Methods
    
    private func getNote() {
        if let noteId = self.noteId {
            textInput.text = UserDefaults.standard.string(forKey: noteId.uuidString) ?? ""
        }
    }
    @objc private func saveNote() {
        if let noteId = self.noteId, let text = textInput.text {
            UserDefaults.standard.set(text, forKey: noteId.uuidString)
            delegate?.didSaveNoteWith(id: noteId, text: text)
            print("Note saved with id: \(noteId)")
        }
    }
    
    private func setupView() {
        [textInput, noteTitle, saveButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textInput.heightAnchor.constraint(equalToConstant: 600),
            textInput.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textInput.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textInput.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            noteTitle.bottomAnchor.constraint(equalTo: textInput.topAnchor, constant: -50),
            noteTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo: textInput.topAnchor),
            saveButton.trailingAnchor.constraint(equalTo: textInput.trailingAnchor)
            
        ])
        
    }
    
}
