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

class CodeBlockElementComposer: BlockElementComposer {
    private var index = [Int]()
    
    func willStart(in context: ComposingContext) {
        index.append(context.views.count)
    }
    
    func willStop(in context: ComposingContext) {
        index = index.dropLast()
    }

    func text(in context: ComposingContext, render: ParmaRenderable) -> Text? {
        print(context.foundCharacters)
        return render.codes(context.foundCharacters)
    }
    
    func view(in context: ComposingContext, render: ParmaRenderable) -> AnyView {
        guard let view = context.views.last else { return AnyView(EmptyView()) }
        return render.codeBlock(view: view)
    }
}
