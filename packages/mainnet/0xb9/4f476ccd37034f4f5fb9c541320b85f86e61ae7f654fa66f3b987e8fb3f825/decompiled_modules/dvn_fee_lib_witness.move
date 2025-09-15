module 0xb94f476ccd37034f4f5fb9c541320b85f86e61ae7f654fa66f3b987e8fb3f825::dvn_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

