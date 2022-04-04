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
                //empty image if wrong url>>>>>>>>>>>>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
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

//@State var zoomsrt : String

struct ContentView: View {
    
    @State private var quoteData: QuoteData? = QuoteData( lat: "21.06268",long: "86.84669") // parada 2 anahuac
    //parada 1 anahuac 21.06227, -86.84641
    
    @State var state = ""
    
    @State var apiURL = ""
    
    //@State var convertedValueRaw: String = "2.0"
    
    //switch case
    
    
    @State private var tiempo = "4:32"
    
    
    @State var zoom = 16.0


    
    var body: some View {
        
        
        
        
        
        
       
        ZStack{
            VStack{
                
                Text(" GPS").bold()
                    .foregroundColor(.red)
                    .fontWeight(.heavy)
                    .font(.title)
                
                
                Text("Tiempo estimado de llegada : 4:32")
                
                
                Text(quoteData?.lat ?? "latitude")
                Text(quoteData?.long ?? "longitude")
                
                
                
                Slider(value: $zoom, in: 10...20)
                
                
                Spacer()
                
                if let lat = quoteData?.lat, let long = quoteData?.long  {
                    var hola = zooming(zoom: zoom)
             
                    //let zoomstr = String(zoom)
                    Spacer()
                    Image(uiImage: "https://maps.googleapis.com/maps/api/staticmap?center=\(lat),\(long)&zoom=\(hola)&maptype=hybrid&size=400x400&key=НЩГКЛУНРУКУ&markers=\(lat),\(long)".load())
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
        guard let url = URL(string: "http://172.20.17.206/cordenadas.json") else{
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

func zooming(zoom :Double) ->String{
    @State var zoomsrt : String
    //Int(zoom)
    
    switch Int(zoom) {
        

    case 10:
        zoomsrt = "10"
        return zoomsrt
        
    case 11:
        zoomsrt = "11"
        return zoomsrt
        
    case 12:
        zoomsrt = "12"
        return zoomsrt
        
    case 13:
        zoomsrt = "13"
        return zoomsrt
        
    case 14:
        zoomsrt = "14"
        return zoomsrt
        

    case 15:
        zoomsrt = "15"
        return zoomsrt
        
    case 16:
        zoomsrt = "16"
        return zoomsrt
        
    case 17:
        zoomsrt = "17"
        return zoomsrt
        
    case 18:
        zoomsrt = "18"
        return zoomsrt

    case 19:
        zoomsrt = "19"
        return zoomsrt
        
    case 20:
        zoomsrt = "20"
        return zoomsrt
        
    case 21:
        zoomsrt = "21"
        return zoomsrt
        
    default:
        zoomsrt = "16"
        return zoomsrt
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
