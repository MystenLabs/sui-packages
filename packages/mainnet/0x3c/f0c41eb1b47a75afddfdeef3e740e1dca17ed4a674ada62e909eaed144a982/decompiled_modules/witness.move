module 0x3cf0c41eb1b47a75afddfdeef3e740e1dca17ed4a674ada62e909eaed144a982::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

