module 0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

