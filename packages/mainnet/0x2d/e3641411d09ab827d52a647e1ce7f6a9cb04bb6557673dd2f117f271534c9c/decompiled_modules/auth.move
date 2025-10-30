module 0x2de3641411d09ab827d52a647e1ce7f6a9cb04bb6557673dd2f117f271534c9c::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

