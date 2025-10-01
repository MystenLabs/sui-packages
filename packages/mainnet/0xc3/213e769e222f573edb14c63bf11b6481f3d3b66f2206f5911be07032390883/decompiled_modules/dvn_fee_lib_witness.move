module 0xc3213e769e222f573edb14c63bf11b6481f3d3b66f2206f5911be07032390883::dvn_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

