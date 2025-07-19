module 0x57bfd5ef2b6006d64f314a3087053f17ca8f6598afb123bc855cd146e7357074::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 13906834238767890431
    }

    // decompiled from Move bytecode v6
}

