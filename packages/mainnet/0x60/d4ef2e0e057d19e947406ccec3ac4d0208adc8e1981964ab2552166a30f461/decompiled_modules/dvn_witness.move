module 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

