//
//  CodeBlockElementComposer.swift
//  Parma
//
//  Created by oBlank on 4/13/21.
//
//  Copyright (c) 2021 oBlank <dyh1919@gmail.com>
//
//  MIT license, see LICENSE file for details

import SwiftUI

class BlockQuoteElementComposer: BlockElementComposer {
    private var index = [Int]()
    
    func willStart(in context: ComposingContext) {
        index.append(context.views.count)
    }
    
    func willStop(in context: ComposingContext) {
        index = index.dropLast()
    }

    // func text(in context: ComposingContext, render: ParmaRenderable) -> Text? {
    //     print("blockquote", context.foundCharacters)
    //     return render.quote(context.foundCharacters)
    // }
    
    func view(in context: ComposingContext, render: ParmaRenderable) -> AnyView {
        let maxIndex = context.views.count
        let minIndex = index.last!
        
        // Get every view inside this element scope
        let views = Array(context.views[minIndex..<maxIndex])
        
        // Remove those views from context
        context.views = context.views.dropLast(maxIndex-minIndex)

        if views.count == 1, let view = views.first {
            return render.blockQuote(view: view)
        } else if views.count > 1 {
            let count = views.count
            return render.blockQuote(view: AnyView(
                VStack(alignment: .leading) {
                    ForEach(0..<count, id: \.self) { index in
                        views[index]
                    }
                }
            ))
        } else {
            return render.blockQuote(view: AnyView(EmptyView()))
        }
    }
}
