module 0x61e9c4c1aa706dcaf8815b76d1a09c96946beead6a02e4d56dafeefc9ef911d5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

