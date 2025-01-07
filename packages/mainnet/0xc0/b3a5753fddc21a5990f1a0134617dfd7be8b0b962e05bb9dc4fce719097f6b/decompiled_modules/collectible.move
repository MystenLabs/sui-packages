module 0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::collectible {
    struct Collectible has drop {
        dummy_field: bool,
    }

    public fun collectible() : Collectible {
        Collectible{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

