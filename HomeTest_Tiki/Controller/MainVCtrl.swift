//
//  MainVCtrl.swift
//  HomeTest_Tiki
//
//  Created by Lu Kien Quoc on 2/20/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import UIKit

class MainVCtrl: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var clvMain: UICollectionView!
    
    // MARK: - Properties
    private var cellID: String = "clvMainCellID"
    private var DEFINIED_PADDING: CGFloat = 16
    
    var keywords: Keywords = Keywords()
    
    var lstKeyword: [KeywordDetail] {
        return keywords.keywords
    }
    
    // MARK: - Init
    
    // MARK: - UIViewController func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
        loadData()
        
    }
    
    // MARK: - Layout UI
    
    // MARK: - Event Handler
    @IBAction func btnReload_Touched(_ sender: UIButton) {
        loadData()
    }
    
    // MARK: - Func
    func loadData() {
        Service.callTiki({
            self.view.showLoadingView($0)
            
        }) { (response) in
            guard let response = response else {
                return
            }
            self.keywords = response
            self.clvMain.reloadData()
        }

    }
    
}

extension MainVCtrl: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func initCollectionView() {
        clvMain.register(UINib(nibName: String(describing: ClvMainCell.self), bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: cellID)
        clvMain.dataSource = self
        clvMain.delegate = self
        clvMain.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lstKeyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ClvMainCell {
            let detail = lstKeyword[indexPath.row]
            cell.updateCell(detail)
            cell.vTitle.backgroundColor = UIColor(hexString: Const.DETAIL_BACKGROUND_COLOR[indexPath.row % Const.DETAIL_BACKGROUND_COLOR.count] )
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let detail = lstKeyword[indexPath.row]
        
        let leftRightPadding: CGFloat = 10
        let label = UILabel()
        label.numberOfLines = Ultities.calNumberOfLine(detail)
        label.text = detail.keyword
        label.font = ClvMainCell.DEFINIED_FONT
        label.frame = CGRect(x: 0, y: 0, width: ClvMainCell.DEFINIED_MIN_WIDTH - leftRightPadding, height: 40)
        label.textAlignment = .center
        label.backgroundColor = .yellow
        label.sizeToFit()
        
        while label.isTruncated {
            label.frame.size.width += 10
        }
//        print("----------")
//        print(detail.keyword)
//        print(label.isTruncated)
        let width = max(ClvMainCell.DEFINIED_MIN_WIDTH, label.frame.size.width + leftRightPadding)
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DEFINIED_PADDING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: DEFINIED_PADDING, left: 0, bottom: DEFINIED_PADDING, right: 0)
    }
}
