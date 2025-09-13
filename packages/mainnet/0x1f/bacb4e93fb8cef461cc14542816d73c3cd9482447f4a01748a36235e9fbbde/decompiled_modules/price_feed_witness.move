module 0x1fbacb4e93fb8cef461cc14542816d73c3cd9482447f4a01748a36235e9fbbde::price_feed_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

