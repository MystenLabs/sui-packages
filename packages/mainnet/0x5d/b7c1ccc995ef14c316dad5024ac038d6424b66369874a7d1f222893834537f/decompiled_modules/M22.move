module 0x5db7c1ccc995ef14c316dad5024ac038d6424b66369874a7d1f222893834537f::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 0
    }

    // decompiled from Move bytecode v6
}

