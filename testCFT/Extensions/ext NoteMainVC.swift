//
//  ext NoteMainVC.swift
//  testCFT
//
//  Created by Дмитрий on 04.02.2024.
//

import UIKit

extension NoteMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notesModel.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteEditViewController = NoteEditViewController()
        let noteItem = notesModel[indexPath.row]
        noteEditViewController.noteId = noteItem.id
        noteEditViewController.delegate = self
        navigationController?.pushViewController(noteEditViewController, animated: true)
    }
    
}


extension NoteMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.identifier, for: indexPath) as! NoteCell
        let noteItem = notesModel[indexPath.row]
        cell.configure(with: noteItem)
        
        return cell
    }
}


