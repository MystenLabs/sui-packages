module 0xd2c8af8ba8a2936556a7e61b24dc5b9751e735f955fb48f87d03444e1406473b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

