module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::witness {
    struct WaterXPerp has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : WaterXPerp {
        WaterXPerp{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

