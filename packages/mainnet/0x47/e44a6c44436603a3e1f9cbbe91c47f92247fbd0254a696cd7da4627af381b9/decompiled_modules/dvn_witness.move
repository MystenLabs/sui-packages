module 0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

