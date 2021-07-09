//
//  ViewController.swift
//  PLAnimate
//
//  Created by 連振甫 on 2021/7/4.
//

import AVKit

enum Animate:String {
    case 火影忍者
    case 神奇寶貝
    case 數碼寶貝
    
    var name:String{
        switch self {
        case .火影忍者:
            return "火影忍者"
        case .神奇寶貝:
            return "神奇寶貝"
        case .數碼寶貝:
            return "數碼寶貝"
        default:
            return ""
        }
    }
    
    var streamsServer:String{
        switch self {
        case .火影忍者:
            return "https://vpx13.myself-bbs.com/42259/"
        case .神奇寶貝:
            return "https://vpx13.myself-bbs.com/45306/"
        case .數碼寶貝:
            return "https://vpx13.myself-bbs.com/45394/"
        default:
            return ""
        }
    }
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let data:[String] = ["火影忍者","神奇寶貝","數碼寶貝"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! VideoCell
        let name = data[indexPath.row]
        
        let title = NSMutableAttributedString(string: name)
        let range = (title.string as NSString).range(of: name)
        title.addAttribute(.link, value: link(data: name), range: range)
        cell.titleLabel.attributedText = title
        cell.myimageView.image = UIImage(named:  name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case Animate.火影忍者.name:
            showMessage(originURL: Animate.火影忍者.streamsServer,type: .火影忍者)
            break
        case Animate.神奇寶貝.name:
            showMessage(originURL: Animate.神奇寶貝.streamsServer,type: .神奇寶貝)
            break
        case Animate.數碼寶貝.name:
            showMessage(originURL: Animate.數碼寶貝.streamsServer,type: .數碼寶貝)
            break
        default:
            break
        }
        
        
    }
    
    func link(data:String) -> String {
        switch data {
        case Animate.火影忍者.name:
            return "https://myself-bbs.com/thread-42259-1-1.html"
            
        case Animate.神奇寶貝.name:
            return "https://myself-bbs.com/thread-45306-1-1.html"
                
        case Animate.數碼寶貝.name:
            return "https://myself-bbs.com/thread-45394-1-2.html"
        default:
            return ""
        }
    }
    
    func showMessage(originURL:String,type:Animate) {
        let alertVC = UIAlertController(title: "要看第幾集？", message: "數碼寶貝記得+94", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "播放", style: .default, handler: { alert -> Void in
            if let textField = alertVC.textFields?.first,let numberStr = textField.text{
                self.goAction(stream: "\(originURL)\(numberStr)/720p.m3u8")
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.keyboardType = .numberPad
        })
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func goAction(stream:String) {
        
        guard let url = URL(string: stream) else {
            return
        }
        
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        
        
        let vc = AVPlayerViewController()
        vc.player = player
        vc.player?.play()
        self.present(vc, animated: true, completion: nil)
        
    }
}
