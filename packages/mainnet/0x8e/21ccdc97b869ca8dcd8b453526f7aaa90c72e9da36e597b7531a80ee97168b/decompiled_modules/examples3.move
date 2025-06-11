module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::examples3 {
    fun example(arg0: &0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Rectangle) : u64 {
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_base(arg0) * 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_height(arg0)
    }

    fun expanded_example(arg0: &0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Rectangle) : u64 {
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_base(arg0) * 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_height(arg0)
    }

    // decompiled from Move bytecode v6
}

