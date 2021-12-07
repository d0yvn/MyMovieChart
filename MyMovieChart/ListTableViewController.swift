import UIKit
import Alamofire
import Foundation
import WebKit
import SafariServices

class ListTableViewController: UITableViewController {
    
    @IBOutlet weak var moreButton: UIButton!
    var page = 1
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        
        return datalist
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callMovieApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func more(_ sender: UIButton) {
        page += 1
        callMovieApi()
        tableView.reloadData()
    }
    func getThumbnailImage(_ index:Int) -> UIImage {
        let mvo = list[index]
        
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url!)
            mvo.thumbnailImage = UIImage(data:imageData)
            
            return mvo.thumbnailImage!
        }
    }
    func callMovieApi(){
        let URL = URL(string: "http://115.68.183.178:2029/hoppin/movies?order=releasedateasc&count=10&page=\(page)&version=1&genreId=")
        
        do {
            let apidata = try Data(contentsOf: URL!)
            
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            if page >= totalCount {
                moreButton.isHidden = true
                let alert = UIAlertController(title: "알림", message: "마지막 페이지입니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
            
            for row in movie {
                let r = row as! NSDictionary
                let mvo = MovieVO()
                
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                mvo.detail = r["linkUrl"] as? String
                
                
                let imageURL = Foundation.URL(string:mvo.thumbnail!)
                let imageData = try! Data(contentsOf: imageURL!)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                self.list.append(mvo)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! MovieTableViewCell
        
        cell.title?.text = movie.title
        cell.desc?.text = movie.description
        cell.opendate?.text = movie.opendate
        cell.rating?.text = "\(movie.rating!)"
        
        DispatchQueue.main.async {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let cell = sender as! MovieTableViewCell
            
            let path = self.tableView.indexPath(for: cell)
            
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }

}
