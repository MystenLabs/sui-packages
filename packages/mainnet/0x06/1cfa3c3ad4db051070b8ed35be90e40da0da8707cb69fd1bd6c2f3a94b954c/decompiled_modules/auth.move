module 0x61cfa3c3ad4db051070b8ed35be90e40da0da8707cb69fd1bd6c2f3a94b954c::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

