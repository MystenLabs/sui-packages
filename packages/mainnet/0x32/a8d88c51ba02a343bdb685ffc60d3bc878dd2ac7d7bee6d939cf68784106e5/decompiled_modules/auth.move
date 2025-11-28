module 0x32a8d88c51ba02a343bdb685ffc60d3bc878dd2ac7d7bee6d939cf68784106e5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

