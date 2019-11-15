# Quiz
Quiz

Using plist

    // ViewDidLoad te code pa
    // save the data to list
    //saveChecklistItems()

    // QList = []
        
    // load the data from list
    // loadChecklistItems()
        
    // PListData: NSCoder, Codable = this is class
    // var QList:[PListData] = []
    
    func loadChecklistItems() {
        // 1
        let path = dataFilePath()
       print("\(path)")
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let decoder = PropertyListDecoder()
            do {
                // 4
                QList = try decoder.decode([PListData].self,from: data)
            }
            catch
            {
                print("Error decoding item array!")
            }
        } }
    
    
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("allData.plist")
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
    func saveChecklistItems() {
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
            // 3
            let data = try encoder.encode(QList)
            // 4
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)}
        catch {
            print("Error encoding item array!")
            // 5
        } }
