//
//  PostVC.swift
//  PaginationTask
//
//  Created by Aniket Rao on 24/02/23.
//

import UIKit

class PostVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    private var posts = [Hit]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var currentPage = 1
    private var isLast = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView(){
        self.tableView.register(UINib(nibName: "PostTVC", bundle: nil), forCellReuseIdentifier: "PostTVC")
        set_API_Data()
    }
    
    func set_API_Data(){
        loadPostData(page: currentPage)
    }
  }

// MARK: - UITabelewv methods
extension PostVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postData = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTVC", for: indexPath) as! PostTVC
        cell.selectionStyle = .none
        cell.configureCell(hit: postData)
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 2 {
            if !isLast {
                currentPage += 1
                loadPostData(page: currentPage)
            }
        }
    }
}

// MARK: - API Calls
extension PostVC {
    
    private func loadPostData(page : Int){
        Services.shared.getPosts(page: page, params: [:]) { [self] data in
            print("Response :\(data)")
            if data.hits?.count == 0 {
                isLast = true
            }
            
            tableView.isHidden = false
            
            if let postsData = data.hits {
                print("Hints Data : \(postsData)")
                posts.append(contentsOf: postsData)
            }
        }
    }
}
