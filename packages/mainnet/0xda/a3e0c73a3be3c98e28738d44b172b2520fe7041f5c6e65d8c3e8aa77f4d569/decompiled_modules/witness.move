module 0xdaa3e0c73a3be3c98e28738d44b172b2520fe7041f5c6e65d8c3e8aa77f4d569::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

