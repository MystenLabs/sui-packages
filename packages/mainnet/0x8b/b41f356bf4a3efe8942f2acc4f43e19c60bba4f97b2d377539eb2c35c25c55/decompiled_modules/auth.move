module 0x8bb41f356bf4a3efe8942f2acc4f43e19c60bba4f97b2d377539eb2c35c25c55::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

