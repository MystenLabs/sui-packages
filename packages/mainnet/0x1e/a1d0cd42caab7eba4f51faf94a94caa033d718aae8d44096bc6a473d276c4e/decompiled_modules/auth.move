module 0x1ea1d0cd42caab7eba4f51faf94a94caa033d718aae8d44096bc6a473d276c4e::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

