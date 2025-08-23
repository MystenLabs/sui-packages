module 0x8a948c51e0fba520f140cdc325760a97fecbd99f33e9cf899cb9893e07bfed1a::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

