module 0xecc4b737e634b9cd0d6f7a7b2ef29160dc1459e3cbc0f4909980bc3ac1b05e86::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

