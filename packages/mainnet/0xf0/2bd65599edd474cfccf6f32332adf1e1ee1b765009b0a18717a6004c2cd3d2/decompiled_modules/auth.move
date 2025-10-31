module 0xf02bd65599edd474cfccf6f32332adf1e1ee1b765009b0a18717a6004c2cd3d2::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

