module 0xea932d79771b24103a1cda8e87a65068d6116c047f9dccc3e487cf8316625576::price_feed_witness {
    struct LayerZeroWitness has drop {
        dummy_field: bool,
    }

    public fun new() : LayerZeroWitness {
        LayerZeroWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

