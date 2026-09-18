module 0x873ee745592fe90effe3588b122e2f3f75efcb903267ffe2a8d4490a057c7b7c::witness {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

