module 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::M22 {
    struct Foo has copy, drop {
        pos0: u64,
    }

    fun x() {
        Foo{pos0: 0};
        abort 0
    }

    // decompiled from Move bytecode v6
}

