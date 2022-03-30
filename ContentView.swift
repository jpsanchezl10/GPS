//
//  ContentView.swift
//  GPS
//
//  Created by JP MBP on 3/25/22.
//

import SwiftUI

extension String{
    func load() ->UIImage {
        
        do{
            //string to URL
            guard let url = URL(string: self) else{
                //empty image if wrong url
                return UIImage()
            }
            //url to data
            let data : Data = try Data(contentsOf: url)
            
            //create uuimage obj from data
            return UIImage(data: data) ?? UIImage()
            
        }catch{
            
            
        }
        return UIImage()
        
    }
}



struct ContentView: View {
   // @State private var quoteData : QuoteData?
    
    @State private var quoteData: QuoteData? = QuoteData( lat: "21.0938",long: "86.5051") // Tokyo
    
    @State var state = ""
    
    @State var apiURL = ""



    
    var body: some View {
        
       
        ZStack{
            VStack{
                Text(" GPS").bold()
                    .foregroundColor(.red)
                    .fontWeight(.heavy)
                    .font(.title)
                
                
                Text(quoteData?.lat ?? "latitude" )
                Text(quoteData?.long ?? "longitude")
                
                
                
                Spacer()
                
                if let lat = quoteData?.lat, let long = quoteData?.long  {
             
                    //Text(lat)
                    //Text(lon)
                    Spacer()
                    Image(uiImage: "https://maps.googleapis.com/maps/api/staticmap?center=\(lat),\(long)&zoom=16&size=400x400&key=YOURKEYHERE=\(lat),\(long)".load())
                        .resizable()
                        .frame(width: 400, height: 400)
                    
                }
                

                
       
                Spacer()
                
                Button("Track") {
                    loadData()
                    textintro()
                    
                }
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .background(Color.blue)
                .font(.title)
                
            }
        }
            .padding()
    }
    func textintro(){
        self.state = "Localizando ..."
            
    }
    
    private func loadData(){
        guard let url = URL(string: "http://gpsanahuac.ngrok.io/cordenadas.json") else{
            return
        }
        URLSession.shared.dataTask(with: url){data , response, error in
            guard let data = data else{
                return
            }
            if let decodedData = try? JSONDecoder().decode(QuoteData.self, from: data){
                DispatchQueue.main.async {
                    self.quoteData = decodedData
                }
            }
        }.resume()
        
    }
    
}

struct QuoteData: Decodable{
    
    var lat: String
    var long: String
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
