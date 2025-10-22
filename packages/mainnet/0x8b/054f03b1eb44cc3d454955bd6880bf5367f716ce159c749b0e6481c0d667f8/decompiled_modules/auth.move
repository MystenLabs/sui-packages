module 0x8b054f03b1eb44cc3d454955bd6880bf5367f716ce159c749b0e6481c0d667f8::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

