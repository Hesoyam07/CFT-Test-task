//
//  NoteMainView.swift
//  testCFT
//
//  Created by Дмитрий on 26.01.2024.
//

import UIKit

final class NoteMainViewController: UIViewController {
    
    //MARK: UI
    var notesModel: [NoteModel] = [NoteModel(text: "test name")]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 350, height: 150)
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .clear
        return button
    }()
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        assignDelegate()
        loadNotes()
        view.backgroundColor = .systemOrange
        addButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
    }
    //MARK: Methods
    @objc private func addNote() {
        let newNote = NoteModel(text: "Type something")
        notesModel.append(newNote)
        saveNotes()
        collectionView.reloadData()
    }
    
    private func saveNotes() {
        let notesData = notesModel.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(notesData, forKey: "savedNotes")
    }
    private func loadNotes() {
        if let savedNotesData = UserDefaults.standard.array(forKey: "savedNotes") as? [Data] {
            notesModel = savedNotesData.map { try! JSONDecoder().decode(NoteModel.self, from: $0) }
        }
    }
    private func assignDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupUI() {
        [collectionView, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
    }
        
}

// MARK: VC Delegate method
extension NoteMainViewController: NoteEditViewControllerDelegate {
    func didSaveNoteWith(id: UUID, text: String) {
        if let index = notesModel.firstIndex(where: { $0.id == id }) {
            notesModel[index].text = text
            saveNotes()
            collectionView.reloadData()
        }
    }
}
