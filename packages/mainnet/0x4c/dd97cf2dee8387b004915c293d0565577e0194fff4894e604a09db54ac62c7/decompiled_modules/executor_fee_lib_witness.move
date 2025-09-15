module 0x4cdd97cf2dee8387b004915c293d0565577e0194fff4894e604a09db54ac62c7::executor_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

