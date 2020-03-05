//
//  ViewController.swift
//  fsp
//
//  Created by WangHJ on 2020/03/03.
//  Copyright © 2020 urobot. All rights reserved.
//

import UIKit
import FSPagerView

class ViewController: UIViewController {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControl: FSPageControl!
    
    fileprivate let imageNames = ["r1.jpg","r2.jpg","r3.png"]
    fileprivate var coverflowContents: [UIImage] = [] {
        didSet {
            self.pagerView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCoverFlowSliderView()
    }
    
    private func setupCoverFlowSliderView() {
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.isInfinite = false
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")

        //pagerView.itemSize = FSPagerView.automaticSize
        let screenSize = UIScreen.main.bounds
        let w = screenSize.width-100
        pagerView.itemSize = CGSize(width: w, height: w)
        pagerView.interitemSpacing = 100
        //pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        for a in imageNames{
            let img = UIImage.init(imageLiteralResourceName: a)
            coverflowContents.append(img)
        }
        
        self.pageControl.setStrokeColor(.black, for: .normal)
        self.pageControl.setStrokeColor(.black, for: .selected)
        self.pageControl.setFillColor(.black, for: .selected)
        self.pageControl.itemSpacing = 16.0
        pageControl.contentHorizontalAlignment = .center
        //pageControl.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pageControl.numberOfPages = self.coverflowContents.count
    }
}

extension ViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return coverflowContents.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let coverflow = coverflowContents[index]

        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86

        cell.imageView?.image = coverflow
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    //---------------------------------------------------------
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}
