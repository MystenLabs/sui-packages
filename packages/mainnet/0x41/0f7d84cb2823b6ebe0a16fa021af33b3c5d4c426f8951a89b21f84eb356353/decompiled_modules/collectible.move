module 0x410f7d84cb2823b6ebe0a16fa021af33b3c5d4c426f8951a89b21f84eb356353::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

