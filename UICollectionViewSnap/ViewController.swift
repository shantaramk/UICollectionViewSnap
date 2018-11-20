
import UIKit

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (self.collectionView!.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<collectionView.visibleCells.count {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.collectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

// MARK: - UICollectionView Delegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItems = 200
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: CategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath as IndexPath) as? CategoryCollectionCell else {
            fatalError("CategoryCollectionCell cell is not found")
        }
        cell.pictureView.backgroundColor = .red
 
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 01, left: 0, bottom: 1, right: 0)
    }
}

// MARK: - Configure UI

extension ViewController {
    
    func setUpCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
        if let object = self as? UICollectionViewDataSource {
            self.collectionView.dataSource = object
        }
        if let object = self as? UICollectionViewDelegate {
            self.collectionView.delegate = object
        }
        updateFlowLayout()
    }
    
    func updateFlowLayout() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let layoutHeight = Device.height * 0.26
        let layoutWidth = layoutHeight * 0.86
        layout.itemSize = CGSize(width: layoutWidth - 10, height: layoutHeight - 10)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.minimumInteritemSpacing = 0.6
        layout.minimumLineSpacing = 0.6
        layout.scrollDirection = .horizontal
        self.collectionView.isScrollEnabled = true
        self.collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
}
