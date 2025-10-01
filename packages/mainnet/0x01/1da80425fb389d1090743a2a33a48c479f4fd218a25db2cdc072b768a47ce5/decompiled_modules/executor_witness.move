module 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

