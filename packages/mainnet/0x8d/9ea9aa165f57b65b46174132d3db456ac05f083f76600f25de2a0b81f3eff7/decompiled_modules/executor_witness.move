module 0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

