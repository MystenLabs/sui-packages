module 0x484edce4a92a852e522b578d45b454390cadb3ed6fe7736c2dbaa685b96b19a6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

