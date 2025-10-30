module 0x397fd452ab326d8e7833c26f9d2d2f6488f4ffb27f4bccfe720cc058fd186d5b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

