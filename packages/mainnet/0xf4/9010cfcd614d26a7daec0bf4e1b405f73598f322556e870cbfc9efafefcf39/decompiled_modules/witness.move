module 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::witness {
    struct DeepbookWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : DeepbookWitness {
        DeepbookWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

