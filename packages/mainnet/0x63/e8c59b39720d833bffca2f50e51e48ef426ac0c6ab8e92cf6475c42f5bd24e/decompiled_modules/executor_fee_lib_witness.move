module 0x63e8c59b39720d833bffca2f50e51e48ef426ac0c6ab8e92cf6475c42f5bd24e::executor_fee_lib_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

