module 0x9683c766ba6a483120310777f13d2329a928f21c8b3ce0509a93f782b0438565::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

