module 0x5c1c3c2eb512dff3fad909a53c435aebd833fac199aeaa83d4464630a4f4b2ad::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

