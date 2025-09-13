module 0xf4a1d39e207110d3abe05c9df7e89844ec56fe2b85d86b674cc018a336a030d8::executor_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

