//
//  Home.swift
//  UI-510
//
//  Created by nyannyan0328 on 2022/03/17.
//

import SwiftUI

struct Home: View {
    @State var currentType : String = "Popular"
    
    @Namespace var animation
    
    @State var headerOffsets : (CGFloat,CGFloat) = (0,0)
    
    @State var _alubums : [Album] = albums
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:0){
                
                
                HeaderView()
                
                LazyVStack(pinnedViews: .sectionHeaders) {
                    
                    Section {
                        
                        SongList()
                        
                    } header: {
                        
                        pinHeaderView()
                            .background(.black)
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0,returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                        
                    }

                }
                
                
            }
        }
        .overlay(content: {

            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)

        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    @ViewBuilder
    func SongList()->some View{
        
        
        VStack(spacing:13){
            
            
            ForEach($_alubums){$alubum in
                
                
                HStack(spacing:10){
                    
                    
                    Text("#\(getIndex(alubum:alubum) + 1)")
                    
                    Image(alubum.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                    
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        Text(alubum.albumName)
                            .fontWeight(.semibold)
                        
                        HStack(spacing:10){
                            
                            
                            Image(systemName: "beats.headphones")
                                .font(.title3)
                              
                            
                            Text("62,689,789")
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .frame(maxWidth:.infinity,alignment:.leading)
                    
                    
                    Button {
                        
                        alubum.isLiked.toggle()
                        
                    } label: {
                        
                        Image(systemName: alubum.isLiked ? "suit.heart.fill" : "suit.heart")
                            .font(.title3)
                            .foregroundColor(alubum.isLiked ? Color("Green") : .white)
                        
                        
                    }
                    
                    
                    
                    Button {
                        
                     
                        
                    } label: {
                        
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        
                    }
                    
                    
                    
                    

                }
                
                
                
            }
            
            
            
        }
        .padding()
        .padding(.top,30)
        .padding(.bottom,150)
        
        
        
    }
    @ViewBuilder
    func pinHeaderView()->some View{
        
        let types: [String] = ["Popular","Albums","Songs","Fans also like","About"]
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing:20){
                
                ForEach(types,id:\.self){type in
                    
                    
                    VStack(spacing:15){
                        
                        
                        
                        Text(type)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .white : .gray)
                        
                        ZStack{
                            
                            if currentType == type{
                                
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.blue)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                
                            }
                            else{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                                    .frame(height: 2)
                                
                                
                            }
                        }
                       
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        withAnimation(.easeInOut){
                            
                            currentType = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top,13)
            .padding(.bottom,5)
        }
     
        
        
    }
    @ViewBuilder
    func HeaderView()->some View{
        
        
        GeometryReader{proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height > 0 ? height : 0,alignment: .top)
                .overlay(content: {
                    
                    
                    ZStack(alignment:.bottom){
                        
                        
                        LinearGradient(colors: [
                        
                            .clear,
                            .black.opacity(0.8)
                        
                        ], startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            Text("Animal")
                            
                            HStack(spacing:15){
                                
                                Text("Lion King")
                                    .font(.title.bold())
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .background{
                                        
                                        Circle()
                                            .fill(.white)
                                            .padding(2)
                                    }
                                
                            }
                            
                            Label {
                                
                                Text("Moth Listerners")
                                    .foregroundColor(.gray.opacity(0.8))
                                
                            } icon: {
                                
                                Text("62,689,789")
                                    .font(.title3)
                            }

                            
                            
                            
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding(.bottom,20)
                        .padding(.leading,20)
                      
                        
                    }
                   
                    
                })
                .cornerRadius(15)
                .offset(y: -minY)
              
        }
        .frame(height: 250)
        
    }
    
    
    func getIndex(alubum : Album)->Int{
        
        return _alubums.firstIndex { currentIndex in
            
            alubum.id == currentIndex.id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
