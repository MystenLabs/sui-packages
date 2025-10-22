module 0x90571327c21236a6ec0bda938d1d11d78b9c13f8d5d00be614388e9b5424193f::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

