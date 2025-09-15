module 0x9f12f79a355fca76492bc1908fc7a9a8518d2a83e65cffc93f134144dfa4e5bb::price_feed_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

