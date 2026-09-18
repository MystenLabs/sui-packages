module 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

