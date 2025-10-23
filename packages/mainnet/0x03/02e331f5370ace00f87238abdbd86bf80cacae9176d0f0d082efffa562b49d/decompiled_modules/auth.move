module 0x302e331f5370ace00f87238abdbd86bf80cacae9176d0f0d082efffa562b49d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

