module 0x625c44bdf2c0ff84dc11562543447c0bda3b2b01749c710dc7e27b747830606::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

