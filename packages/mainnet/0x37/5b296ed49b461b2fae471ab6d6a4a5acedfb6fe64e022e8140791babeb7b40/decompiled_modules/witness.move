module 0x375b296ed49b461b2fae471ab6d6a4a5acedfb6fe64e022e8140791babeb7b40::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

