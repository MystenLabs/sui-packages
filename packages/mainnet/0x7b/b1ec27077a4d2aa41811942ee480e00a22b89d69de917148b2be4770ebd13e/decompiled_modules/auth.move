module 0x7bb1ec27077a4d2aa41811942ee480e00a22b89d69de917148b2be4770ebd13e::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

