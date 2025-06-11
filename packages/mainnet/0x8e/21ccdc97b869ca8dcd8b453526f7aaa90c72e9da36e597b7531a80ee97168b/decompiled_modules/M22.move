module 0x8e21ccdc97b869ca8dcd8b453526f7aaa90c72e9da36e597b7531a80ee97168b::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 13906834238767890431
    }

    // decompiled from Move bytecode v6
}

