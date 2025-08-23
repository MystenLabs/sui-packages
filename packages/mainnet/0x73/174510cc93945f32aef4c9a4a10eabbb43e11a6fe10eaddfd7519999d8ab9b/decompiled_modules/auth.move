module 0x73174510cc93945f32aef4c9a4a10eabbb43e11a6fe10eaddfd7519999d8ab9b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

