module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::examples2 {
    fun example(arg0: &0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Rectangle) : 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Box {
        into_box(arg0, 1)
    }

    fun expanded_example(arg0: &0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Rectangle) : 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Box {
        into_box(arg0, 1)
    }

    fun into_box(arg0: &0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Rectangle, arg1: u64) : 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::Box {
        0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::box(0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_base(arg0), 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::shapes::rectangle_height(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

