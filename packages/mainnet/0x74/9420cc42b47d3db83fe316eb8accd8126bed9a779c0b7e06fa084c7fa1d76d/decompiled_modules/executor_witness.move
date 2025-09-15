module 0x749420cc42b47d3db83fe316eb8accd8126bed9a779c0b7e06fa084c7fa1d76d::executor_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

