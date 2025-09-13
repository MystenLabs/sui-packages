module 0x6b25ab1e9681f46d8893924ba5a6cd265ba3226cf33bb8706d26afc1e853084f::dvn_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

